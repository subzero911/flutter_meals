import 'package:flutter/material.dart';
import 'package:mealsapp/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),

//            buildContainer(
//              ListView.builder(
//                itemCount: selectedMeal.ingredients.length,
//                itemBuilder: (ctx, index) => Card(
//                  color: Theme.of(context).accentColor,
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                    child: Text(selectedMeal.ingredients[index]),
//                  ),
//                ),
//              ),
//            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 10,
                children: <Widget>[
                  for (var ingredient in selectedMeal.ingredients)
                    Chip(
                      backgroundColor: Theme.of(context).accentColor,
                      label: Text(ingredient, style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                ],
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
