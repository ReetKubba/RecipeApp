import 'package:flutter/material.dart';
import './dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  @override
  var toggleFavourite;
  var isFavourite;
  MealDetailScreen(this.toggleFavourite, this.isFavourite);
  static const routeName = 'meal-detail';
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  Widget build(BuildContext context) {
    //check this
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeals = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var title;
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeals.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeals.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'INGREDIENTS'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeals.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(selectedMeals.ingredients[index])),
                ),
              ),
            ),
            buildSectionTitle(context, 'STEPS'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(selectedMeals.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeals.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavourite(mealId) ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () => toggleFavourite(mealId),
        //  onPressed: toggleFavourite,
      ),
    );
  }
}
