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

  Future<void> updateCategory(BuildContext context, String categoryId,
      String currentCategoryName) async {
    TextEditingController controller =
        TextEditingController(text: currentCategoryName);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Category"),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  // Update the category in Firestore
                  await FirebaseFirestore.instance
                      .collection('Categories')
                      .doc(categoryId)
                      .update({
                    'categoryName': controller.text,
                  });

                  Navigator.pop(context);
                } else {
                  // Show an error message or handle empty field case
                }
              },
              child: Text("Update"),
            ),
            TextButton(
              onPressed: () async {
                // Delete the category from Firestore
                await FirebaseFirestore.instance
                    .collection('Categories')
                    .doc(categoryId)
                    .delete();

                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('Categories').get(),
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
            itemBuilder: (BuildContext context, int index) {
              String categoryId = snapshot.data!.docs[index].id;
              String categoryName =
                  categoriesData[index]['categoryName'].toString();
              return CategoryButton(
                categoryName: categoryName,
                onPressed: () {
                  Navigator.pushNamed(context, '/questions',
                      arguments: categories[index]);
                },
                onLongPressed: () {
                  // Long press to update the category
                  updateCategory(context, categoryId, categoryName);
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
  final VoidCallback onLongPressed;

  const CategoryButton({
    Key? key,
    required this.categoryName,
    required this.onPressed,
    required this.onLongPressed,
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
          onLongPress: onLongPressed,
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
