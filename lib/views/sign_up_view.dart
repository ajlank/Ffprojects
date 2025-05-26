import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simpletodo/constants/route_constants.dart';
import 'package:simpletodo/utilites/dialoges.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  String emailError='';
  String passwordError='';
  
  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(
            'Sign Up', 
             style: GoogleFonts.aladin(
              fontSize: 30,
             )
             ,)),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    ),
                  hintText: 'email'
                ),
              ),
            ),
           Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: SizedBox(
               width: double.infinity,
               child: Text(emailError, 
               style: TextStyle(color: Colors.red,),), 

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: TextField(
                controller: _password,
                enableSuggestions: false,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    ),
                  hintText: 'password'
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(25,0, 0, 0),
              child: SizedBox(
               width: double.infinity,
               child: Text(passwordError, 
               style: TextStyle(color: Colors.red,),), 

              ),
            ),
            TextButton(onPressed: ()async{
             final email=_email.text;
             final password=_password.text;
             
           try{
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, 
              password: password
              );
              final currentUser=FirebaseAuth.instance.currentUser;
              await currentUser?.sendEmailVerification();
              if(context.mounted){
                Navigator.of(context).pushNamedAndRemoveUntil(emailverifyRoute, (route)=>false);
              }
             
           }on FirebaseAuthException catch(e){
             if(e.code=='email-already-in-use'){
              setState(() {
               emailError="User already exists!"; 
              });
               
             }else if(e.code=='invalid-email'){
             setState(() {
                emailError="Invalid email";
             });
             }
             else if(e.code=='weak-password'){
              setState(() {
                passwordError="Weak password. Use 6 digits password";
              });
             }else{
              if(context.mounted){
                await showErrorDialog(context);
              }else{
                return;
              }

             }
           }catch(e){
             if(context.mounted){
                await showErrorDialog(context);
              }else{
                return;
              }

           }
            
            }, child: const Text('Sign Up')),
            TextButton(onPressed: (){
               if(context.mounted){
             Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route)=>false);
            }else{
              return;
            }
            }, child: const Text('Already registered? login here'))
           
        ],
      ),
    );
  }
}
