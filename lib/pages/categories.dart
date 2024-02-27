import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late CollectionReference<Map<String, dynamic>> collection;

  @override
  void initState() {
    super.initState();
    collection = FirebaseFirestore.instance.collection('Categories');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: collection.get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<Map<String, dynamic>> categoriesData = snapshot.data!.docs
              .map((DocumentSnapshot document) =>
                  document.data() as Map<String, dynamic>)
              .toList();
          print(snapshot.data!.docs.map((doc) => doc.data()));

          categoriesData.forEach((category) {
            print(
                'category: $category, categoryName: ${category['categoryName']}');
          });
          List<String> categories = categoriesData
              .map((category) => category['categoryName'].toString())
              .toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: categories.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              String categoryName = categoriesData
                  .where((category) => category != null)
                  .toList()[index]['categoryName']
                  .toString();
              print(categoryName);
              return CategoryButton(
                categoryName: categoryName,
                onPressed: () {
                  Navigator.pushNamed(context, '/questions',
                      arguments: categories[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String categoryName;
  final VoidCallback onPressed;

  const CategoryButton({
    Key? key,
    required this.categoryName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Material(
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(16.0),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: Text(
            categoryName,
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}
