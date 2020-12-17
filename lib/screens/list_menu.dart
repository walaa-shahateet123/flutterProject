import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_methods.dart';
import 'package:restaurant_app/components/home_components.dart';
import 'package:restaurant_app/models/menu.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';

class ListMenuScreen extends StatelessWidget {
  final int id;
  Restaurant restaurant;
  ListMenuScreen({this.id, this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Menu'),
        actions: [IconButton(
          icon: Icon(Icons.favorite),
          onPressed: ()=>Navigator.of(context).pushNamed(FavoriteItem.id),)
        ],

      ),
      body: FutureBuilder(
        future: APIMethods.getMenus('$id'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var menus = snapshot.data;
          return ListView.builder(
            itemCount: menus.length,
            itemBuilder: (_, i) {
              Menu menu = menus[i];
              return MenuItem(
                menu: menu,
                restaurant: restaurant,
              );
            },
          );
        },
      ),
    );
  }
}
