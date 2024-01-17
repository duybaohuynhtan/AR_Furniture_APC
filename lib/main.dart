import 'package:ar_furniture_app/onboarding_page.dart';
import 'package:csv/csv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String csvData = await rootBundle.loadString(
    "assets/product_data.csv",
  );
  List<List<dynamic>> productList = const CsvToListConverter().convert(csvData);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConcentricAnimationOnboarding(productList: productList),
    ),
  );
}
