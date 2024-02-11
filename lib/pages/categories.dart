import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
    'Category 6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: GridView.builder(
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
            style: TextStyle(
                // color: Colors.white, // Uncomment if you want to specify the text color
                ),
          ),
        ),
      ),
    );
  }
}
