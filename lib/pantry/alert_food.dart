import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pantry_management/pantry/add_products/add_products_bloc.dart';


class AlertFood extends StatefulWidget {
  AlertFood({
    Key? key,
  }) : super(key: key);

  @override
  State<AlertFood> createState() => _AlertFoodState();
}

class _AlertFoodState extends State<AlertFood> {

final _productController = TextEditingController();
final _quantityController = TextEditingController();
DateTime date = DateTime(2022, 12, 2);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: const Text('Add product'),
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
                    hintText: "Product Name",
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
                    hintText: "Quantity",
                  ),
                ),
                //DatePickerExample()
                buildDate(context),
              ],
            ),
            actions: <Widget>[
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
                  print("Product Name: ${_productController.text}");
                  print("Quantity: ${_quantityController.text}");
                  print("Expiration Date: ${date}");
                  BlocProvider.of<AddProductsBloc>(context).add(
                    AddToListEvent(
                      product_name: _productController.text,
                      quantity: int.parse(_quantityController.text),
                      expiration_date: date));
                  Navigator.pop(context, 'OK');
                },
                child: const Text('Continue',
                    style: TextStyle(
                        color:
                            Color.fromARGB(255, 122, 39, 160))),
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
                              initialDateTime: date,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              // This is called when the user changes the date.
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => date = newDate);
                              },
                            ),
                          ),
                          child: Text(
                            '${date.month}-${date.day}-${date.year}',
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
