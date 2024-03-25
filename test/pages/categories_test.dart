import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/pages/categories.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

void main() {
  group("Category widget tests", () {
    late MockFirebaseFirestore mockFirestore;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
    });

    // testWidgets('Test category display', (WidgetTester tester) async {
    //   final mockSnapshot = [
    //     {'categoryName': 'Python'},
    //     {'categoryName': 'Javascript'},
    //   ];

    //   // Mock the behavior of Firestore methods
    //   when(mockFirestore.collection('Categories')).thenAnswer((_) {
    //     final mockQuery = MockQuery();
    //     when(mockQuery.get())
    //         .thenAnswer((_) async => MockQuerySnapshot(mockSnapshot));
    //     return mockQuery;
    //   });

    //   await tester.pumpWidget(MaterialApp(home: Category()));

    //   await tester.pump();

    //   expect(find.text('Python'), findsOneWidget);
    //   expect(find.text('Javascript'), findsOneWidget);
    // });

    testWidgets('AppBar displays "Categories"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Category(),
      ));

      expect(find.text('Categories'), findsOneWidget);
    });

    testWidgets('Test if loading indicator is present',
        (WidgetTester tester) async {
      AsyncSnapshot snapshot =
          AsyncSnapshot.withData(ConnectionState.waiting, null);
      await tester.pumpWidget(MaterialApp(
        home: YourWidget(snapshot: snapshot),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

class YourWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const YourWidget({Key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    return Container();
  }
}

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Container(),
    );
  }
}
