import 'package:analytics_tut/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Auth.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          OutlineButton(
            onPressed: () async {
              await context.read<AuthenticationService>().loginGoogle();
              final user = context.read<User>();
              context.read<UserHelper>().saveUser(user);
            },
            borderSide: BorderSide(color: Colors.orangeAccent),
            child: Text("Sign In"),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ));
  }
}
