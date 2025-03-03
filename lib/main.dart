import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/car_model_provider.dart';
import 'screens/car_model_home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarModelProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Model App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CarModelHome(),
    );
  }
}
