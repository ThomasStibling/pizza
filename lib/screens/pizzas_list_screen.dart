import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_pizza/models/pizza.dart';
import 'package:new_pizza/providers/pizza_provider.dart';

class PizzasListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizzas List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by pizza name',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                Provider.of<PizzaProvider>(context, listen: false)
                    .filterPizzas(query);
              },
            ),
          ),
          Expanded(
            child: Consumer<PizzaProvider>(
              builder: (context, pizzaProvider, child) {
                return ListView.builder(
                  itemCount: pizzaProvider.pizzas.length,
                  itemBuilder: (context, index) {
                    Pizza pizza = pizzaProvider.pizzas[index];
                    return ListTile(
                      leading: Image.network(
                        'https://pizzas.shrp.dev/assets/${pizza.image}',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(pizza.name),
                      subtitle: Text('Price: €${pizza.price}'),
                      onTap: () {
                        Navigator.pushNamed(context, '/pizza_details',
                            arguments: pizza);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
