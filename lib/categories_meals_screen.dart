import 'package:flutter/cupertino.dart';
import './dummy_data.dart';
import 'package:flutter/material.dart';
import './meals.dart';
import './meals_item.dart';

class displayedMealscreen extends StatefulWidget {
  @override
  // final String categoryId;
  // final String categoryTitle;
  // displayedMealscreen(this.categoryId, this.categoryTitle);
  static const routeName = '/category_meals';
  final List<Meal> availableMeals;
  @override
  displayedMealscreen(this.availableMeals);
  State<displayedMealscreen> createState() => _displayedMealscreenState();
}

class _displayedMealscreenState extends State<displayedMealscreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  void _removeMeal(String Mealid) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == Mealid);
    });
  }

  var _loadedInitState = false;
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    if (_loadedInitState == false) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'].toString();
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((Meal) {
        return Meal.categories.contains(categoryId);
      }).toList();
      _loadedInitState == true;
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return mealsItems(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageURL: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
           
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
