import 'package:flutter/material.dart';
import './dummy_data.dart';
import './categories_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  @override
  final String id;
  final String title;
  final Color color;
  CategoryItem(this.id, this.title, this.color);
  Widget build(BuildContext context) {
    void selectCategory(BuildContext ctx) {
      Navigator.of(ctx).pushNamed(displayedMealscreen.routeName, arguments: {
        'id': id,
        'title': title,
      });
    }

    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title, style: Theme.of(context).textTheme.headline1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
