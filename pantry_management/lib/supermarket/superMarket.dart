import 'package:flutter/material.dart';
import 'package:pantry_management/home/menu.dart';

void main() => runApp(const SuperMarket());

class SuperMarket extends StatelessWidget {
  const SuperMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(width:250, child: userMenu(context)),
      appBar: AppBar(
        title: Text("Supermarkets")
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: Column(
                  children: [
                    // Map API here.
                    // map image
                    Image.asset('assets/IMG_7388.PNG')
                  ],
                ),
              )
            ],
          ),
        ]
      )
    );
  }
}
