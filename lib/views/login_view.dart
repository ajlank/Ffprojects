import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simpletodo/constants/route_constants.dart';
import 'package:simpletodo/utilites/dialoges.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  String loginEmailError='';
  String loginPasswordError='';
  
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
            'Login', 
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
               child: Text(loginEmailError, 
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
               child: Text(loginPasswordError, 
               style: TextStyle(color: Colors.red,),), 

              ),
            ),
          TextButton(onPressed: ()async{
             final email=_email.text;
             final password=_password.text;
             
           try{
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
            final currentUser=FirebaseAuth.instance.currentUser;
            if(currentUser!=null){
             if(currentUser.emailVerified){
              if(context.mounted){
                Navigator.of(context).pushNamedAndRemoveUntil(notesRoute,
                 (route)=>false);
              }
             }
            }else{
              return;
            }
           }on FirebaseAuthException catch(e){
             if(e.code=='user-not-found'){
            setState(() {
              loginEmailError="User doesn't exists";
            });
             }else if(e.code=='wrong-password'){
               setState(() {
                 loginPasswordError="Wrong password.";
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
           
            
            }, child: const Text('Login')),
            TextButton(onPressed: (){
               if(context.mounted){
             Navigator.of(context).pushNamedAndRemoveUntil(signUpRoute, (route)=>false);
            }else{
              return;
            }
            }, child: const Text('Not registerred yet? login here'))
           
        ],
      ),
    );
  }
}