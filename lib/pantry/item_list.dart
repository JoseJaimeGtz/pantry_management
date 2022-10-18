import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 76, 77, 77),
            width:0.5
            ),
            ),
            ),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Avocado"),
                Text("5"),
                Text("17/09/22"),
              ]),
        ),
      ),
    );
  }
}