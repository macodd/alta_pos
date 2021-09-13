import 'package:alta_pos/components/app_bar.dart';
import 'package:alta_pos/models/cart.dart';
import 'package:alta_pos/models/product.dart';
import 'package:alta_pos/utils/global.dart';
import 'package:alta_pos/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// Price Input Page
/// Allows the users to input a price between 10 and 500
/// to be defined as the items unit price.
/// The user can see the total amount of the
/// price + 5% for the service
class PriceInputScreen extends StatefulWidget {
  PriceInputScreen({key, required this.product}) : super(key: key);

  final Product product;

  @override
  _PriceInputScreenState createState() => _PriceInputScreenState();
}

/// Price Input Page
/// Allows the users to input a price between 10 and 500
/// to be defined as the items unit price.
/// The user can see the total amount of the
/// price + 5% for the service
/// Stateful for transforming int to double and show
/// it to the user
class _PriceInputScreenState extends State<PriceInputScreen> {

  double _displayAmount = 0.0;

  String _errorMsg = '';

  // controller used for validating input from user
  final TextEditingController _amountController = TextEditingController();

  // key used for validating the amount form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  ///
  /// dispose of controllers
  ///
  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  /// Displays the amount in decimal format
  /// fixed with 2 decimal places and rounded up.
  Widget displayAmount() {
    return Card(
      elevation: 10.0,
      color: ColorStyle.primaryColor,
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "\$ " + _displayAmount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      )
    );
  }


  ///
  /// Text input hidden from user to input
  /// amount in integer form
  ///
  Widget amountInput() {
    return Opacity(
      opacity: 0.0,
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: TextFormField(
          autofocus: true,
          controller: _amountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          validator: (val) {
            if (val == null || val.isEmpty) {
              setState(() {
                _errorMsg = "Amount can't be zero";
              });
              return "Amount can't be zero";
            }
            double tmp = double.parse(val);
            double total = tmp/100;

            if (total < 1 || total > 500) {
              setState(() {
                _errorMsg = 'Value must be between 10 and 300 USD';
              });
              return 'Value must be between 10 and 300 USD';
            }
            return null;
          },
          onChanged: (val) {
            double display, tmp;

            if (val.isNotEmpty) {
              tmp = double.parse(val);
              display = tmp/100;
            }
            else {
              display = 0.0;
            }
            setState(() {
              _errorMsg = '';
              _displayAmount = display;
            });
          },
        )
      )
    );
  }

  Widget displayErrorMsg() {
    return Text(
      _errorMsg,
      style: TextStyle(
        color: Colors.red
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 90),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.download_outlined,
            size: 20,
          ),
          SizedBox(width: 10),
          Text(
            "Update",
            style: TextStyle(
                fontFamily: "Gotik",
                color: Colors.white
            ),
          ),
        ],
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          double tmp = double.parse(_amountController.text);
          double total = tmp/100;
          print(total);
          // add the price of the last item to the list
          CartItem newItem = new CartItem(widget.product.name, widget.product.sku, total);
          // add item to list in order
          currentOrder.cart.addToCart(newItem.sku, newItem);
          // push to next page
          FocusScope.of(context).unfocus();
          Navigator.pushNamed(context, '/cart');
        }
        else {
          setState(() {
            _amountController.clear();
          });
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, 'Amount'),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product:',
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 14
                      ),
                    ),
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current price:',
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 14
                      ),
                    ),
                    Text(
                      widget.product.initialPrice.toStringAsFixed(2),
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'New Price',
                  style: TextStyle(
                      fontFamily: "Popins",
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Stack(
                  fit: StackFit.loose,
                  children: [
                    // Shows amount in decimal form
                    displayAmount(),
                    // call to keyboard
                    amountInput()
                  ],
                ),
                displayErrorMsg(),
                SizedBox(height: 30),
                submitButton(),   // show the bottom button
              ]
            )
          )
        ),
      ),
    );
  }
}
