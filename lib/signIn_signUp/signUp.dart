import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/signIn_signUp/auth_bloc/auth_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

class _SignUpState extends State<SignUp> {

  bool isChecked = true;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top:100, left:50, right:50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.grey[800]
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Text('Email',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 49, 155),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Your email address",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey
                                ),
                              ),  
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 112, 49, 155)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 22),
                    Row(
                      children: [
                        Text('Password',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 49, 155),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                              hintText: "••••••••",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey
                                ),
                              ),  
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 112, 49, 155)
                                ),
                              ),
                              suffixIcon: IconButton(
                                iconSize: 26,
                                icon: Icon(Icons.remove_red_eye,
                                    color: showPassword
                                        ? Color.fromARGB(255, 112, 49, 155)
                                        : Colors.grey[400]),
                                onPressed: () {
                                  showPassword = !showPassword;
                                  setState(() {});
                                },
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          ),
                          fillColor: MaterialStateProperty.all(Color.fromARGB(255, 112, 49, 155)),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Row(
                              children: [
                                Text('I agree to the '),
                                Text('Terms of Services ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 112, 49, 155),
                                    fontWeight: FontWeight.w800
                                  )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('and '),
                                Text('Privacy Policy.',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 112, 49, 155),
                                    fontWeight: FontWeight.w800
                                  )
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print(
                                  "email on form: ${_emailController.text}");
                              print(
                                  "password on form: ${_passwordController.text}");
                              print("Creating User with Form");
                              if (isChecked == false) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Oops...',
                                  text: 'Read and Agree Terms of Services',
                                );
                              } else {
                                BlocProvider.of<AuthBloc>(context).add(
                                    CreateUserEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text));
                                Navigator.pop(context);
                                _emailController.text = '';
                                _passwordController.text = '';
                              }
                            },
                            child: Text('Continue',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              )
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              primary: Color.fromARGB(255, 112, 49, 155),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Have an Account?',
                          style: TextStyle(
                            color: Colors.grey[500],
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signIn');
                          },
                          child: Text('Sign In',
                            style: TextStyle(
                              color: Color.fromARGB(255, 112, 49, 155),
                              fontWeight: FontWeight.w800,
                              fontSize: 16
                            )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}