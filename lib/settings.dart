import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_management/home/menu.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/signIn_signUp/auth_bloc/auth_bloc.dart';
import 'package:pantry_management/signIn_signUp/user_auth_repository.dart';

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
                      child: Image.network(UserAuthRepository().getCurrentUser()?.photoURL
                      ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')),
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
                                enabled: false,
                                border: InputBorder.none,
                                hintText: UserAuthRepository().getCurrentUser()?.displayName ?? UserAuthRepository().getCurrentUser()?.email ?? 'User'
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
                                hintText: UserAuthRepository().getCurrentUser()?.email ?? 'Email'
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Secure',
                            text: 'Your Account is Secure!',
                          );
                        },
                        icon: Icon(FontAwesomeIcons.lock))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Container(
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: Text('Save',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 16
                  //       )
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Color.fromARGB(255, 3, 95, 200),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(6),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Signing out");
                        Navigator.of(context).pop();
                        BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.info,
                          title: 'Info',
                          text: 'Signing Out',
                        );
                      },
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
