import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharp_mind/components/button.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Quiz")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleSection(),
              TextSection(),
              Button(
                buttonText: 'start quiz',
                onPressed: () {
                  Navigator.pushNamed(context, '/categories');
                },
              ),
            ],
          ),
        ));
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, left: 70),
                  child: Button(
                      buttonText: 'Result',
                      onPressed: () {
                        Navigator.pushNamed(context, '/results');
                      }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Button(
                        buttonText: "Logout",
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, '/');
                          } catch (e) {
                            print("Error while logging out $e");
                          }
                        })
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser!.email;
    print("user------> $currentUser");
    return Container(
      padding: const EdgeInsets.all(32),
      child: currentUser != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome user with email:, ${currentUser}!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'You can start the quiz by clicking the button below.',
                  softWrap: true,
                ),
              ],
            )
          : Text(
              'Welcome to the quiz app. Please log in to start the quiz.',
              softWrap: true,
            ),
    );
  }
}
