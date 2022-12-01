import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pantry_management/pantry/add_products/add_products_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pantry_management/pantry/edit_food.dart';

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
  @override
  Widget build(BuildContext context) {
    CollectionReference productQuery =
        FirebaseFirestore.instance.collection('users_pantry');
    final FirebaseAuth auth = FirebaseAuth.instance;
    //final ingredientsQuery = productQuery.doc(auth.currentUser!.uid).get();

    return BlocConsumer<AddProductsBloc, AddProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is AddProductsInitial || state is AddProductSuccess || state is UpdateProductSuccess || state is DeleteProductSuccess){
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
            body: FutureBuilder<DocumentSnapshot>(
                future: productQuery.doc(auth.currentUser!.uid).get(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> user =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return _buildUsersIngredients(user, context);
                    }
                  }
                  return Center(
                      child: LoadingBouncingGrid.square(
                    inverted: true,
                    borderColor: Colors.black,
                    borderSize: 1.0,
                    size: 100.0,
                    backgroundColor: Color.fromARGB(255, 122, 39, 160),
                    duration: Duration(seconds: 1),
                  ));
                })),
            drawer: Container(width: 250, child: userMenu(context)));
      }
      return Center(
            child: LoadingBouncingGrid.square(
            inverted: true,
            borderColor: Colors.black,
            borderSize: 1.0,
            size: 100.0,
            backgroundColor: Color.fromARGB(255, 122, 39, 160),
            duration: Duration(seconds: 1),
          ));
      }
    );
  }
}

Widget _buildUsersIngredients(Map<String, dynamic> data, BuildContext context) {
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
          )),
      ListHeader(),
      for (var i = 0; i < data["ingredients"].length; i++)
        GestureDetector(
          onTap: () {
            print(data["ingredients"][i]["product_name"]);
            print(data["ingredients"][i]["quantity"]);
            print(data["ingredients"][i]["expiration_date"]);
            //Mostrar el modal para agregar los productos
            showDialog<String>(
            context: context,
            builder: (BuildContext context) => EditFood(
              product_name: data["ingredients"][i]["product_name"],
              quantity: data["ingredients"][i]["quantity"],
              expiration_date: data["ingredients"][i]["expiration_date"],
              id: i
            ));
          },
          child: ItemList(
              product_name: data["ingredients"][i]["product_name"],
              quantity: data["ingredients"][i]["quantity"],
              date: data["ingredients"][i]["expiration_date"]),
        )
    ],
  );
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
    String formattedDate = DateFormat('dd-MM-yyyy').format(new_date);


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
            Container(width: 90, child: Text("${product_name}")),
            Text("${quantity}"),
            Text("${formattedDate}"),
          ]),
        ),
      ),
    );
  }
}
