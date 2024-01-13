import 'package:ar_furniture_app/onboarding_page.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String csvData = await rootBundle.loadString(
    "assets/product_data.csv",
  );
  List<List<dynamic>> productList = const CsvToListConverter().convert(csvData);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConcentricAnimationOnboarding(productList: productList),
    ),
  );
}
