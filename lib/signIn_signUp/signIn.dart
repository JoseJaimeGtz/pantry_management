import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/http_requests/http_request_search_recipes_by_ingredients.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}
final _emailController = TextEditingController();
final _passwordController = TextEditingController();


var request = HttpRequest();

class _SignInState extends State<SignIn> {

bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 50),
                        Icon(FontAwesomeIcons.cloud,
                          size: 70,
                          color: Color.fromARGB(255, 112, 49, 155)
                        ),
                        SizedBox(height: 8),
                        Text('Save your food',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey
                          ),
                        )
                      ],
                    )
                  ]
                ),
                SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Sign In',
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
                                hintText: "example@email.com",
                                //labelText: 'example@email.com',
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
                                  icon: Icon(Icons.remove_red_eye, color: showPassword 
                                    ? Color.fromARGB(255, 112, 49, 155) 
                                    : Colors.grey[400]
                                  ),
                                  onPressed: () {
                                    showPassword =! showPassword;
                                    setState(() {});
                                  },
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // print(request.getRecipesByIngredients('apples,flour,sugar'));
                                // print(request.getSimilarRecipes('156992'));
                                print(request.getRecipeInformation('156992'));
                              },
                              child: Text('Sign In',
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('or log in with Facebook',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              label: Text('Facebook',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                )
                              ),
                              icon: Icon(FontAwesomeIcons.facebookF, size: 20),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                primary: Color.fromARGB(255, 64, 90, 147),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Forgot Password?',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              )
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signUp');
                            },
                            child: Text('Sign Up',
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
      ),
    );
  }
}