import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/signIn_signUp/auth_bloc/auth_bloc.dart';
import 'package:pantry_management/signIn_signUp/user_auth_repository.dart';
import 'package:pantry_management/supermarket/superMarket.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
                    backgroundImage: NetworkImage(UserAuthRepository().getCurrentUser()?.photoURL
                      ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    ),
                    radius: 50.0
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(UserAuthRepository().getCurrentUser()?.displayName ?? UserAuthRepository().getCurrentUser()?.email ?? 'User',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ),
                  Text(UserAuthRepository().getCurrentUser()?.email ?? 'Email',
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
          ListTile(
            minLeadingWidth: 40 - 20,
            leading: Icon(Icons.logout, size: 25),
            title: const Text('Log Out'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                title: 'Info',
                text: 'Signing Out',
              );
            }
          ),
          SizedBox(height:250),
          ListTile(
            minLeadingWidth: 40 - 20,
            leading: Icon(FontAwesomeIcons.gear, size: 20),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            } 
          ),
        ],
      ),
    );
  }