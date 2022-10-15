import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/home/menu.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

final _nameController = TextEditingController();
class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(width:250, child: userMenu(context)),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network('https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=7lrLYx-B')),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 45,
                            width: 250,
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Johana Doe'
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            height: 45,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                enabled: false, // si queremos cambiar el correo, quitar esto
                                border: InputBorder.none,
                                hintText: 'johana@company.com'
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.lock))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Save',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 3, 95, 200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Log out',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 200, 3, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
