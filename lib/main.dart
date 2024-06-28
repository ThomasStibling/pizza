import 'package:flutter/material.dart';
import 'package:new_pizza/screens/login_screen.dart';
import 'package:new_pizza/screens/pizza_details_screen.dart';
import 'package:new_pizza/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:new_pizza/providers/pizza_provider.dart';
import 'package:new_pizza/providers/cart_provider.dart';
import 'package:new_pizza/screens/pizzas_list_screen.dart';

import 'package:new_pizza/screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PizzaProvider()..fetchPizzas()),
        ChangeNotifierProvider(
            create: (context) => CartProvider()..loadCartFromPrefs()),
      ],
      child: MaterialApp(
        title: 'Pizza App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/pizza_list': (context) => PizzasListScreen(),
          '/pizza_details': (context) => PizzaDetailsScreen(),
          '/cart': (context) => CartScreen(),
          '/': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
        },
      ),
    );
  }
}
