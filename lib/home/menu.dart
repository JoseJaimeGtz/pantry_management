import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/supermarket/superMarket.dart';

Widget userMenu(BuildContext context) {
    return Drawer(
      child: Column(
        // padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 300,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: <Widget>[ 
                  // SizedBox(height: 20),
                  ListTile(
                    title: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            print('cerrado');
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close, color: Color.fromARGB(255, 122, 39, 160)) //no se detecta el click
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    backgroundImage: NetworkImage(
                      'https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=7lrLYx-B'
                    ),
                    radius: 50.0
                  ),
                  Text('Johana Doe',
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  Text('johana@company.com',
                    style: TextStyle(fontWeight: FontWeight.w300)
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: 40 - 20,
            leading: Icon(FontAwesomeIcons.burger, size: 20),
            title: const Text('Your Food'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () => Navigator.pushNamed(context, '/yourFood')
          ),
          ListTile(
            minLeadingWidth: 40 - 20,
            leading: Icon(FontAwesomeIcons.bookOpen, size: 20),
            title: const Text('Recipes'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () => Navigator.pushNamed(context, '/recipes')
          ),
          ListTile(
            minLeadingWidth: 40 - 20,
            leading: Icon(FontAwesomeIcons.cartShopping, size: 20),
            title: const Text('SMKT map'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () => Navigator.pushNamed(context, '/superMarket')
          ),
          SizedBox(height:250),
          ListTile(
            minLeadingWidth: 40 - 20,
            leading: Icon(FontAwesomeIcons.gear, size: 20),
            title: const Text('Settings'),
            onTap: () => Navigator.pushNamed(context, '/settings')
          ),
        ],
      ),
    );
  }