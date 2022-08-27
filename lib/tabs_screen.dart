import 'package:flutter/material.dart';
import 'package:recipeapp/main_drawer.dart';
import './favourite_screen.dart';
import './categories_screen.dart';
import './meals.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  @override
  TabsScreen(this.favouriteMeals);
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // TabsScreen(this.favouriteMeals);
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': favouriteScreen(widget.favouriteMeals),
        'title': 'Favourites Screen'
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'].toString(),
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          //type:BottomNavigationBarType.shifting,
          items: [
            //:Theme.of(context).primaryColor
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                //title: Text('category'),
                label: 'Category'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
              // title:  Text('favourites'),
            ),
          ]),
      //TabBarView(children:<Widget> [
      //   CategoriesScreen(),favouriteScreen(),
      //],
      //),
    );
  }
}
