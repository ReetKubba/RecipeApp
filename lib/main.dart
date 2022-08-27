import 'dart:developer';

import 'package:flutter/material.dart';
import 'categories_screen.dart';
import './models/categories.dart';
import 'dummy_data.dart';
import './categories_meals_screen.dart';
import './meals.dart';
import './meal_detail_screen.dart';
import './tabs_screen.dart';
import './favourite_screen.dart';
import 'FilterScreen.dart';

void main() => runApp(recipeApp());

class recipeApp extends StatefulWidget {
  @override
  State<recipeApp> createState() => _recipeAppState();
}

class _recipeAppState extends State<recipeApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];
  void _setFilters(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegeterian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((thisone) => thisone.id == mealId);
    log('pring indexWhere statements $existingIndex');
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((thisone) => thisone.id == mealId),
        );
      });
    }
  }

  bool _isfavouriteMeal(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Delimeals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(225, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline1: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        //   home: CategoriesScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(_favouriteMeals),
          displayedMealscreen.routeName: (ctx) =>
              displayedMealscreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(_toggleFavorite, _isfavouriteMeal),
          FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
        });
  }
}
