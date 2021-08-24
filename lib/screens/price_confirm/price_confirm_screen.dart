import 'package:alta_pos/components/app_bar.dart';
import 'package:alta_pos/models/cart.dart';
import 'package:alta_pos/models/product.dart';
import 'package:alta_pos/screens/price_update/price_update_screen.dart';
import 'package:alta_pos/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:alta_pos/utils/order_setup.dart';


class ConfirmPriceScreen extends StatelessWidget {
  final Product product;

  ConfirmPriceScreen({key, required this.product}) : super(key: key);

  Widget priceScreenTitle() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Add product to cart?',
          style: TextStyle(
              fontFamily: 'Sans'
          ),
        )
    );
  }

  Widget cardProduct() {
    return Card(
      margin: const EdgeInsets.all(0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
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
          ),
        ),
        trailing: Text(
          product.initialPrice.toStringAsFixed(2),
          style: TextStyle(
              fontFamily: "Popins",
              fontSize: 16.0
          ),
        ),
      ),
    );
  }

  Widget navigateToCart(context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorStyle.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 90)
        ),
        onPressed: () {
          CURRENT_ORDER.getCart().addToCart(
              product.sku,
              CartItem(product.name, product.sku, product.initialPrice)
          );
          Navigator.pushNamed(context, '/cart');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add
            ),
            SizedBox(width: 10),
            Text(
              "Add",
              style: TextStyle(
                fontFamily: 'Popins',
                color: Colors.white,
              ),
            ),
          ],
        )
    );
  }

  Widget navigateToEdit(context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: ColorStyle.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 90)
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PriceInputScreen(product: product))
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_outlined,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              "Edit",
              style: TextStyle(
                fontFamily: 'Popins',
                color: Colors.white,
              ),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, 'Confirm'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                priceScreenTitle(),
                cardProduct(),
                SizedBox(height: 20),
                navigateToCart(context),
                SizedBox(height: 20),
                navigateToEdit(context)
              ],
            ),
          )
        )
      )
    );
  }
}