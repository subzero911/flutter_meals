import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget _buildAppBar(selectedMeal) {
    return SliverAppBar(
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          selectedMeal.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      pinned: true,
      title: Text('${selectedMeal.title}'),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildChips(context, selectedMeal) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(selectedMeal),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              //_buildHeaderImage(selectedMeal),
              _buildSectionTitle(context, 'Ingredients'),
              _buildChips(context, selectedMeal),
              _buildSectionTitle(context, 'Steps'),
            ]),
          ),
          SliverFillRemaining(            
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(                
                physics: NeverScrollableScrollPhysics(),
                itemCount: selectedMeal.steps.length,
                separatorBuilder: (ctx, index) => Divider(),
                itemBuilder: (ctx, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${(index + 1)}'),
                  ),
                  title: Text(
                    selectedMeal.steps[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorite(mealId),
        //Navigator.of(context).pop(mealId);
      ),
    );
  }
}
