import 'package:flutter/material.dart';
import './meals.dart';
import './meals_item.dart';

class favouriteScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  favouriteScreen(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favourites !!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return mealsItems(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageURL: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
            affordability: favouriteMeals[index].affordability,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
