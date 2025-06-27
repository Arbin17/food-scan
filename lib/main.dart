import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_scanner_app/scan_page.dart';
import 'nutrition_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NutritionProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Scanner',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ScanPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
