import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_pizza/providers/pizza_provider.dart';

class PizzasListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pizzaProvider = Provider.of<PizzaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Pizzas'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pizzaProvider.pizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
                'https://pizzas.shrp.dev/assets/${pizzaProvider.pizzas[index].image}'),
            title: Text(pizzaProvider.pizzas[index].name),
            subtitle:
                Text('Prix: \€${pizzaProvider.pizzas[index].price.toString()}'),
            onTap: () {
              Navigator.pushNamed(context, '/pizza_details',
                  arguments: pizzaProvider.pizzas[index]);
            },
          );
        },
      ),
    );
  }
}
