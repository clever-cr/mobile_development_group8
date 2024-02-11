import 'package:flutter/material.dart';
import 'package:namer_app/components/button.dart';

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
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
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
  const TextSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Welcome to the quiz app. You can start the quiz by clicking the button below.',
        softWrap: true,
      ),
    );
  }
}
