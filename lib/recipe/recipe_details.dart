import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_management/home/menu.dart';

void main() => runApp(const RecipeDetails());

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(width:250, child: userMenu(context)),
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network('https://www.unileverfoodsolutions.com.co/dam/global-ufs/mcos/nola/colombia/calcmenu/recipes/CO-recipes/rice-dishes/arroz-con-pollo/main-header.jpg')),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Wrap(
                children: [
                  Text('Char-Grilled Beef Tenderloin with Three-Herb Chimichurri', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(0, 45, 42, 42))
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                            FontAwesomeIcons.userGroup, 
                            color: Color.fromARGB(255, 122, 39, 160)
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Servings",
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                             SizedBox(height: 2),
                            Text("10")
                          ],
                        ),
                        VerticalDivider(thickness: 2, color: Colors.grey),
                        Column(
                          children: [
                            Icon(
                            FontAwesomeIcons.stopwatch, 
                            color: Color.fromARGB(255, 122, 39, 160),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Cooking Time",
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                             SizedBox(height: 2),
                            Text("45 min")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- 1 1/2 teaspoons chipotle chile powder or ancho chile powder'),
                  Text('- 1 3 1/2-pound beef tenderloin'),
                  Text('- 1/2 teaspoon freshly ground black pepper'),
                  Text('- 1 tablespoon coarse kosher salt'),
                  Text('- 2 tablespoons dark brown sugar'),
                  Text('- 2 cups (packed) stemmed fresh cilantro'),
                  Text('- 1 cup (packed) stemmed fresh mint'),
                  Text('- 3 cups (packed) stemmed fresh parsley'),
                  Text('- 3 garlic cloves, peeled'),
                  Text('- 1 teaspoon ground black pepper'),
                  Text('- 3 tablespoons fresh lemon juice'),
                  Text('- 3/4 cup olive oil'),
                  Text('- 2 tablespoons olive oil'),
                  Text('- 1/2 teaspoon dried crushed red pepper'),
                  Text('- 3 tablespoons Sherry wine vinegar or red wine vinegar'),
                  Text('- 1 teaspoon fine sea salt'),
                  Text('- 2 medium shallots, peeled, quartered'),
                  Text('- 1 tablespoon sweet smoked paprika*'),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
