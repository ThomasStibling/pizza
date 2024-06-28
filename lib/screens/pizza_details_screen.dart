import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_pizza/models/pizza.dart';
import 'package:new_pizza/providers/cart_provider.dart';
import 'package:new_pizza/services/api_service.dart';
import 'package:new_pizza/models/ingredient.dart';

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
            FutureBuilder<List<Ingredient>>(
              future: ApiService.fetchListIngredients(pizza.elements),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final ingredients = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingredients.map((ingredient) {
                      return Row(
                        children: [
                          Image.network(
                            'https://pizzas.shrp.dev/assets/${ingredient.image}',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 8),
                          Text(
                            ingredient.name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                } else {
                  return Text('No ingredients found');
                }
              },
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addItem(pizza);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pizza added to cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
