import 'package:alta_pos/components/app_bar.dart';
import 'package:alta_pos/examples/example_objects.dart';
import 'package:alta_pos/screens/price_confirm/price_confirm_screen.dart';

import 'package:flutter/material.dart';

class ProductsListScreen extends StatefulWidget {
  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {

  @override
  void initState() {
    super.initState();
  }

  Widget productsList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 100),
        itemCount: PRODUCTS.length,
        itemBuilder: (context, index) {
          final product = PRODUCTS.elementAt(index);
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ConfirmPriceScreen(product: product)));
              },
              title: Text(
                product.name,
                style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                product.description,
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 10.0
                )
              ),
              trailing: Text(
                product.initialPrice.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 16
                ),
              ),
            ),
          );
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: generalAppBar(context, 'Products'),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              productsList(),
            ]
          )
        )
      ),
      onWillPop: () async => false
    );
  }
}
