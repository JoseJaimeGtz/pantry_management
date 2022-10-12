import 'package:flutter/material.dart';

void main() => runApp(const SuperMarket());

class SuperMarket extends StatelessWidget {
  const SuperMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Icon(Icons.keyboard_backspace)
        ),
        body: Column(
          children: [
            Row(
              children: [
                Text("Supermarkets"),
              ],
            ),
            Container(
              child: Column(
                children: [
                  // map image
                  Image.asset('/assets/googleMaps.png')
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
