import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget _buildHeaderImage(selectedMeal) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Image.network(
        selectedMeal.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildChips(context, selectedMeal) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        children: <Widget>[
          for (var ingredient in selectedMeal.ingredients)
            Chip(
              backgroundColor: Theme.of(context).accentColor,
              label: Text(
                ingredient,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepsContainer(Widget child) {
    return Container(      
      height: 250,
      width: double.infinity,
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
            _buildHeaderImage(selectedMeal),
            _buildSectionTitle(context, 'Ingredients'),
            _buildChips(context, selectedMeal),
            _buildSectionTitle(context, 'Steps'),
            _buildStepsContainer(
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
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorite(mealId),
        //Navigator.of(context).pop(mealId);
      ),
    );
  }
}
