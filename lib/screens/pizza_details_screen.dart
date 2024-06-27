import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_pizza/models/pizza.dart';
import 'package:new_pizza/providers/cart_provider.dart';

class PizzaDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pizza pizza = ModalRoute.of(context)!.settings.arguments as Pizza;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(pizza.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://pizzas.shrp.dev/assets/${pizza.image}',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 16),
            Text('Name: ${pizza.name}', style: TextStyle(fontSize: 20)),
            Text('Price: €${pizza.price}', style: TextStyle(fontSize: 20)),
            Text('Base: ${pizza.base}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text('Ingredients:', style: TextStyle(fontSize: 20)),
            for (var ingredient in pizza.ingredients)
              Text('- $ingredient', style: TextStyle(fontSize: 18)),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addItem(
                      pizza); // Appel à la méthode addItem du CartProvider
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pizza ajoutée au panier'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Ajouter au panier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
