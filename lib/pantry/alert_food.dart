import 'package:flutter/material.dart';
import 'package:pantry_management/pantry/date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlertFood extends StatelessWidget {
  const AlertFood({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                      child: Icon(FontAwesomeIcons.carrot,
                          color: Color.fromARGB(
                              255, 122, 39, 160)),
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
                      child: Icon(FontAwesomeIcons.hashtag,
                          color: Color.fromARGB(
                              255, 122, 39, 160)),
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
                        color:
                            Color.fromARGB(255, 122, 39, 160))),
              ),
              TextButton(
                onPressed: () {
                  //context.read<Recipe_Provider>().addRecipe(recipe);
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Continuar',
                    style: TextStyle(
                        color:
                            Color.fromARGB(255, 122, 39, 160))),
              ),
            ]);
  }
}