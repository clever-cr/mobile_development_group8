import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
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
            return CircularProgressIndicator(); // Loading indicator while waiting for data
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Process the documents from the snapshot
          List<String> categories =
              snapshot.data?.docs.map((doc) => doc.id).toList() ?? [];

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoryButton(
                categoryName: categories[index],
                onPressed: () {
                  Navigator.pushNamed(context, '/questions');
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
