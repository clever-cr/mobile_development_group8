import 'package:flutter/material.dart';
import 'package:sharp_mind/components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Question extends StatelessWidget {


  const Question({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ModalRoute.of(context)!.settings.arguments;
    print("..........");
    print(selectedCategory);
    CollectionReference newQuestions =
        FirebaseFirestore.instance.collection('questions');
    Future<void> addQuestion() {
      return newQuestions
          .add(
            {
              'questionText': "Datatypes in js",
              "answer_id": "2",
              "category_id": "1",
              "correctAnswer": "Bingo"
            },
          )
          .then((value) => print("Question Added"))
          .catchError((error) => print("Failed to add question: $error"));
    }

    return Scaffold(
      appBar: AppBar(title: Text("Questions for Python")),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('questions')
            .where('categoryName', isEqualTo: selectedCategory)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final List<Map<String, dynamic>> questions = snapshot.data?.docs
                  .map((DocumentSnapshot document) =>
                      document.data() as Map<String, dynamic>)
                  .toList() ??
              [];

          return Center(
            child: Column(
              children: [
                for (var question in questions)
                  Column(
                    children: [
                      Text(question['Question'] ?? ''),
                      Button(
                        buttonText: question['correctAnswer'] ?? '',
                        onPressed: () {
                          Navigator.pushNamed(context, '/results');
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    addQuestion();
                  },
                  child: Text('Add Question'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
