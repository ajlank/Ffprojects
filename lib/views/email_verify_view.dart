import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/constants/route_constants.dart';

class EmailVerifyView extends StatelessWidget {
  const EmailVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email verification center'),
        centerTitle: true,
      ),
    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          ),
          const Text('A verification mail was sent to your email. Please check it. If you did not recieve yet, then press the following [ Verify my email ] button and check your email. After verifying yourself come here and press [ Verification Confirmed ] button to login.'),
          TextButton(onPressed: ()async{
            final user=FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          }, child: const Text('Verify my email')),
          TextButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            if(context.mounted){
             Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route)=>false);
            }else{
              return;
            }
          }, child: const Text('Verification Confirmed'))
        ],
      ),
    ),
    );
  }
}