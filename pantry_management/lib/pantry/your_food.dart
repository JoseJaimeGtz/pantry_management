import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/pantry/date_picker.dart';

import '../home/menu.dart';

class YourFood extends StatefulWidget {
  const YourFood({
    Key? key,
  }) : super(key: key);

  @override
  State<YourFood> createState() => _YourFoodState();
}

class _YourFoodState extends State<YourFood> {
  String searchValue = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EasySearchBar(
          backgroundColor: Color.fromARGB(255, 122, 39, 160),
          titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
          searchBackIconTheme:
              IconThemeData(color: Color.fromARGB(255, 122, 39, 160)),
          title: Text('Your Food'),
          onSearch: (value) => setState(() => searchValue = value),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                print("Hola");
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                            title: const Text('Add product'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  enabled: true,
                                  decoration: InputDecoration(
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 23, maxHeight: 20),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Icon(
                                        FontAwesomeIcons.carrot,
                                        color: Color.fromARGB(255, 122, 39, 160)
                                      ),
                                    ),
                                    hintText: "Product Name",
                                  ),
                                ),
                                TextFormField(
                                  enabled: true,
                                  decoration: InputDecoration(
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 23, maxHeight: 20),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Icon(
                                        FontAwesomeIcons.hashtag,
                                        color: Color.fromARGB(255, 122, 39, 160)
                                      ),
                                    ),
                                    hintText: "Quantity",
                                  ),
                                ),
                                DatePickerExample()
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancelar',
                                    style: TextStyle(
                                        color:Color.fromARGB(255, 122, 39, 160))),
                              ),
                              TextButton(
                                onPressed: () {
                                  //context.read<Recipe_Provider>().addRecipe(recipe);
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('Continuar',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 122, 39, 160))),
                              ),
                            ]));
              },
            )
          ],
        ),
        body: Column(
          children: [],
        ),
        drawer: Container(width: 250, child: userMenu(context)));
  }
}




