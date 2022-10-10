import 'package:flutter/material.dart';
import 'package:pantry_management/recipe/recipes.dart';
import 'package:pantry_management/signIn_signUp/signIn.dart';
import 'package:pantry_management/signIn_signUp/signUp.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
            child: Text('Recipes page')
          )
        ],
      )
    );
  }
}
