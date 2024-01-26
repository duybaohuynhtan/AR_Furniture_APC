import 'package:ar_furniture_app/product_controller.dart';
import 'package:ar_furniture_app/second_page.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

import 'cart_page.dart';
import 'main.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<_AppState> childKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AR Furniture",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                        childKey.currentState?.clearProducts();
                        (context as Element).markNeedsBuild();
                      })
                    ],
                    children: const [
                      Divider(),
                    ],
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: App(key: childKey),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Product> products = [];

  int indexx = 0;

  @override
  Widget build(BuildContext context) {
    for (var product in productList) {
      products.add(
        Product(
          index: indexx,
          name: '${product[0]}',
          img: "${product[2]}",
          price: "${product[1]} ¥",
          type: "${product[4]}",
        ),
      );
      indexx++;
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: renderAsynchSearchableListview(),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderAsynchSearchableListview() {
    return SearchableList<Product>.async(
      builder: (displayedList, itemIndex, item) {
        return ProductItem(meme: displayedList[itemIndex]);
      },
      errorWidget: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Error while fetching products',
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 5));
        return products;
      },
      asyncListFilter: (query, list) {
        return products
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()) ||
                element.type.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      reverse: false,
      style: const TextStyle(fontSize: 20),
      emptyWidget: const EmptyView(),
      onRefresh: () async {},
      onItemSelected: (Product item) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SecondPage(index: item.index)));
      },
      inputDecoration: InputDecoration(
        labelText: "Search for Product",
        labelStyle: const TextStyle(fontSize: 20),
        alignLabelWithHint: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      closeKeyboardWhenScrolling: true,
    );
  }

  void clearProducts() {
    products.clear();
  }
}

class ProductItem extends StatelessWidget {
  final Product meme;

  const ProductItem({
    Key? key,
    required this.meme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black45,
        margin: const EdgeInsets.all(5),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black26)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  meme.img,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meme.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    meme.price,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text(
          'No product is found with this name',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
