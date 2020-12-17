import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_methods.dart';
import 'package:restaurant_app/components/home_components.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';
import 'package:restaurant_app/screens/list_menu.dart';
import 'package:restaurant_app/screens/order_screen.dart';
import 'package:restaurant_app/utils/size.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'HomeScreen';
  List restaurantsID = [];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.of(context).pushNamed(FavoriteItem.id),
          ),

        ],
      ),
      body: FutureBuilder(
        future: APIMethods.getAllRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator());
          }
          var restaurants = snapshot.data;

          restaurants.forEach((r) {
            restaurantsID.add(r.id);
          });
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (_, i) {
              Restaurant restaurant = restaurants[i];
              return FlatButton(
                child: RestaurantItem(restaurant: restaurant),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return ListMenuScreen(
                          id: restaurant.id,
                          restaurant: restaurant,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return OrderScreen(); 
            }));
          }),
    );
  }
}
