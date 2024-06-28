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
            const SizedBox(height: 16),
            Text('Name: ${pizza.name}', style: const TextStyle(fontSize: 20)),
            Text('Price: €${pizza.price}',
                style: const TextStyle(fontSize: 20)),
            Text('Base: ${pizza.base}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            const Text('Ingredients:', style: TextStyle(fontSize: 20)),
            FutureBuilder<Pizza>(
              future: ApiService.fetchPizzaById(pizza.id),
              builder: (context, snapshot) {
                print('erreur context $context');
                print('erreur snapshot: $snapshot');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final Pizza p = snapshot.data!;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: p.elements!.length,
                      itemBuilder: (context, index) {
                        Ingredient ingredient = p.elements![index];

                        print(ingredient);

                        return ListTile(
                          leading: Image.network(
                            'https://pizzas.shrp.dev/assets/${ingredient.image}',
                            width: 50,
                            height: 50,
                          ),
                          title: Text(ingredient.name),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('No ingredients found');
                }
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addItem(pizza);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pizza added to cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
