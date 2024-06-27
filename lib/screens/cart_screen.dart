import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_pizza/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return ListTile(
                  leading: Image.network(
                      'https://pizzas.shrp.dev/assets/${item.pizza.image}.jpg'),
                  title: Text(item.pizza.name),
                  subtitle: Text(
                      'Prix: \$${item.pizza.price} x ${item.quantity} = \€${item.totalPrice}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.updateQuantity(
                              item.pizza.id, item.quantity - 1);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartProvider.updateQuantity(
                              item.pizza.id, item.quantity + 1);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Total: \€${cartProvider.totalPrice}'),
          ),
          ElevatedButton(
            onPressed: () {
              // Logic to proceed with order
            },
            child: Text('Passer commande'),
          ),
        ],
      ),
    );
  }
}
