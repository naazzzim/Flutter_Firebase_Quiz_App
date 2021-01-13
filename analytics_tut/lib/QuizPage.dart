import 'package:analytics_tut/ResultsPage.dart';
import 'package:analytics_tut/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'qna.dart';

class QuizPage extends StatelessWidget {
  final _answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    final _initialscore =
        FirebaseFirestore.instance.collection("users").doc(user.email).get();
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(user.email)
          .snapshots(),
      initialData: _initialscore,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: Text("Loading😁")));
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data['score'].toString()),
                Text(questionAndAnswers[snapshot.data['score']]
                    ['Question Text']),
                TextField(
                  controller: _answerController,
                  decoration: InputDecoration(labelText: "You Loser😂"),
                  onSubmitted: (value) async {
                    // ignore: unnecessary_statements
                    if (equalsIgnoreCase(value,
                        questionAndAnswers[snapshot.data['score']]['Answer'])) {
                      if ((snapshot.data['score']) ==
                          (questionAndAnswers.length - 1)) {
                        await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ResultsPage()));
                      }
                      await context.read<UserHelper>().updateUser(user);
                      _answerController.clear();
                    }
                  },
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.exit_to_app),
              shape: StadiumBorder(
                  side: BorderSide(
                color: Colors.yellow,
              )),
              onPressed: () => context.read<AuthenticationService>().signOut()),
        );
      },
    );
  }
}
