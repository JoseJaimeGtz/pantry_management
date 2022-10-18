import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/pantry/date_picker.dart';

import '../home/menu.dart';
import 'alert_food.dart';
import 'item_list.dart';

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
                //Mostrar el modal para agregar los productos
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertFood());
              },
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Expires soon",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    SizedBox(width: 20),
                    Icon(FontAwesomeIcons.calendarXmark)
                  ],
                ),
              ),
              //First ListView
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListHeader(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList()
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Expires later",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                         SizedBox(width: 20),
                    Icon(FontAwesomeIcons.calendarCheck)
                  ],
                ),
              ),
              //Second ListView
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListHeader(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList(),
                  ItemList()
                ],
              )
            ],
          ),
        )),
        drawer: Container(width: 250, child: userMenu(context)));
  }
}

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      shadowColor: Color.fromARGB(255, 85, 26, 156),
      child: Container(
        color: Color.fromARGB(255, 110, 110, 110),
        child: ListTile(
          visualDensity: VisualDensity(vertical: -4),
          title: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Quantity",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Exp. Date",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
