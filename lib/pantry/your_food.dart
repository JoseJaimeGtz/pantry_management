import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/pantry/add_products/add_products_bloc.dart';
import 'package:intl/intl.dart';

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
    final FirebaseAuth auth = FirebaseAuth.instance;
    //final productQuery = FirebaseFirestore.instance.collection('users_pantry').doc(auth.currentUser!.uid).get();
    final productQuery = FirebaseFirestore.instance.collection('users_pantry');
    //final ingredientsQuery = productQuery.doc(auth.currentUser!.uid).get();


    return BlocConsumer<AddProductsBloc, AddProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Your Food'),
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
            body: FirestoreListView<Map<String, dynamic>>(
                query: productQuery,
                itemBuilder: (context, snapshot) {
                  dynamic ingredients = snapshot['ingredients'];
                  print(ingredients);
                  //Text("${ingredients}");
                  return Column(
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
                      ListHeader(),
                      for (var i = 0; i < ingredients.length; i++)
                        ItemList(
                            product_name: ingredients[i]["product_name"],
                            quantity: ingredients[i]["quantity"],
                            date: ingredients[i]["expiration_date"])
                    ],
                  );
                },
              ),
        drawer: Container(width: 250, child: userMenu(context)));
      },
    );
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Quantity",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Exp. Date",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  String product_name;
  int quantity;
  Timestamp date;

  ItemList(
      {super.key,
      required this.product_name,
      required this.quantity,
      required this.date});

  @override
  Widget build(BuildContext context) {
    DateTime new_date = DateTime.parse(date.toDate().toString());
    String formattedDate = DateFormat('yyyy-MM-dd').format(new_date);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom:
              BorderSide(color: Color.fromARGB(255, 76, 77, 77), width: 0.5),
        ),
      ),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(width:90, child: Text("${product_name}")),
            Text("${quantity}"),
            Text("${formattedDate}"),
          ]),
        ),
      ),
    );
  }
}
