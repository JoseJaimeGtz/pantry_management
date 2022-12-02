import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pantry_management/pantry/add_products/add_products_bloc.dart';
import 'package:intl/intl.dart';


class EditFood extends StatefulWidget {

  final String product_name;
  final int quantity;
  final Timestamp expiration_date;
  final int id;

  EditFood(
      {
      Key ? key,
      required this.product_name,
      required this.quantity,
      required this.expiration_date,
      required this.id});

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  //static Timestamp get expiration_date => expiration_date;
  //DateTime _new_date = DateTime.parse(expiration_date.toDate().toString());
  DateTime _new_date = DateTime(2022, 12, 2);

  set new_date(DateTime value) {
    _new_date = value;
    //print(expiration_date);
  }
  DateTime get new_date => _new_date;

  @override
  Widget build(BuildContext context) {
  final _productController = TextEditingController(text: "${widget.product_name}");
  final _quantityController = TextEditingController(text: "${widget.quantity}");
  //DateTime new_date = DateTime.parse(widget.expiration_date.toDate().toString());

    return AlertDialog(
            title: const Text('Edit/Remove Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _productController,
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
                    hintText: "${widget.product_name}",
                  ),
                ),
                TextFormField(
                  controller: _quantityController,
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
                    hintText: "${widget.quantity}",
                  ),
                ),
                //DatePickerExample()
                buildDate(context),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: IconButton(
                      onPressed: (){
                        dynamic deletedIngredient = {
                      "expiration_date": widget.expiration_date,
                      "product_name": _productController.text,
                      "quantity":int.parse(_quantityController.text)
                    };

                     //print(deletedIngredient);

                    BlocProvider.of<AddProductsBloc>(context).add(
                      DeleteProductEvent(deletedIngredient : deletedIngredient, id: widget.id));

                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.delete, color:Color.fromARGB(255, 122, 39, 160), size:30)
                ),
                  ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            color:
                                Color.fromARGB(255, 122, 39, 160))),
                  ),
              TextButton(
                onPressed: () {
                  //print("Product Name: ${_productController.text}");
                  //print("Quantity: ${int.parse(_quantityController.text)}");
                  //print("Expiration Date: ${widget.expiration_date}");
                  print("New Expiration Date: ${new_date}");

                 //TODO: Actualizar valores
                dynamic updatedIngredient = {
                  "expiration_date": new_date,
                  "product_name": _productController.text,
                  "quantity":int.parse(_quantityController.text)
                };

                dynamic deletedIngredient = {
                  "expiration_date": widget.expiration_date,
                  "product_name": widget.product_name,
                  "quantity": widget.quantity
                };

                 //print(updatedIngredient);

                BlocProvider.of<AddProductsBloc>(context).add(
                    UpdateProductEvent(updatedIngredient : updatedIngredient, id: widget.id, deletedIngredient:deletedIngredient));
                    
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Update',
                    style: TextStyle(
                        color:
                            Color.fromARGB(255, 122, 39, 160))),
              ),
                ],
              ),
                ],
              ),
            ]);
  }


  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  Widget buildDate(BuildContext context) {
    //DateTime new_date = DateTime.parse(widget.expiration_date.toDate().toString());
    //DateTime updated_date = DateTime(2016, 10, 26);
    //DateTime date = new_date;
    //String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    return Row(
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color: Color.fromARGB(255, 98, 98, 101),
              fontSize: 16.0,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 245,
                    child: _DatePickerItem(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.calendarWeek,
                            size: 20, color: Color.fromARGB(255, 122, 39, 160)),
                        SizedBox(width: 20),
                        const Text('Date'),
                        SizedBox(width: 40),
                        CupertinoButton(
                          // Display a CupertinoDatePicker in date picker mode.
                          onPressed: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: new_date,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              // This is called when the user changes the date.
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => new_date = newDate);
                                //print("New date ${new_date}");
                              },
                            ),
                          ),
                          child: Text(
                            '${new_date.month}-${new_date.day}-${new_date.year}',
                            //'${formattedDate}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}

// This class simply decorates a row of widgets.
class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}
