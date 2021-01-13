import 'package:analytics_tut/QuizPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'SignInPage.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return user == null ? SignInPage() : QuizPage();
  }
}
