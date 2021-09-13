import 'package:alta_pos/utils/global.dart';
import 'package:alta_pos/utils/style.dart';
import 'package:flutter/material.dart';

/// Cart Page
/// Allows the users to see the final state
/// of the cart with its items and the total.
/// Allows users to keep adding items if necessary.
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  double _orderTotal = 0.0;

  bool _isCommissionSwitched = false;
  bool _isTransactionFeeSwitched = false;

  @override
  void initState() {
    _orderTotal = currentOrder.total;
    _isCommissionSwitched = currentOrder.commission;
    _isTransactionFeeSwitched = currentOrder.transactionFee;
    super.initState();
  }

  PreferredSizeWidget cartAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Theme.of(context).canvasColor,
      brightness: Brightness.dark,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: BackButton(
          color: ColorStyle.grayBackground,
          onPressed: null
        )
      ),
      title: Text(
          'Cart',
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5
          )
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {
            currentOrder.clear();
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
          child: Text(
            'X',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          )
        )
      ],
    );
  }

  Widget addCommission() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Add 5% to total'),
        Switch(
          value: _isCommissionSwitched,
          onChanged: (val) {
            setState(() {
              _isCommissionSwitched = val;
              currentOrder.setCommission();
              _orderTotal = currentOrder.total;
            });
          },
          activeTrackColor: Colors.green,
          activeColor: Colors.white,
        )
      ],
    );
  }

  Widget addTransactionFee() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Add .50 USD to total'),
        Switch(
          value: _isTransactionFeeSwitched,
          onChanged: (val) {
            setState(() {
              _isTransactionFeeSwitched = val;
              currentOrder.setTransactionFee();
              _orderTotal = currentOrder.total;
            });
          },
          activeTrackColor: Colors.green,
          activeColor: Colors.white
        )
      ],
    );
  }

  Widget displayList() {
    var order = currentOrder.cart;
    return Expanded(
        child: ListView.builder(
          itemCount: order.numOfItems,
          itemBuilder: (context, index) {
            final item = order.getItem(index);
            return Dismissible(
                key: Key(item!.sku),
                onDismissed: (direction) {
                  setState(() {
                    order.removeItem(item.sku);
                    _orderTotal = order.getCartTotal();
                  });
                  // Then show a snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          )
                      ),
                      content: Text(
                        "${item.name} removed",
                        style: TextStyle(
                            fontFamily: 'Sans'
                        ),
                      )
                    )
                  );
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      item.name,
                      style: TextStyle(
                        fontFamily: 'Popins',
                        fontSize: 16
                      ),
                    ),
                    subtitle: Text(
                      "SKU: ${item.sku}",
                      style: TextStyle(
                        fontFamily: 'Popins',
                        fontSize: 12
                      ),
                    ),
                    trailing: Text(
                      item.finalPrice.toStringAsFixed(2),
                      style: TextStyle(
                          fontFamily: 'Popins'
                      ),
                    )
                )
            );
          },
        )
    );
  }

  Widget productsTitle() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white)),
        Text('\t\tProducts\t\t', style: TextStyle(fontFamily: "Popins")),
        Expanded(child: Divider(color: Colors.white),),
      ],
    );
  }

  Widget bottomConfirmBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.add, size: 16)
                  ),
                  Text(
                    "add more items",
                    style: TextStyle(
                        fontFamily: 'Gotik'
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/products');
              },
            ),
            ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "Total: \$ ${_orderTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontFamily: "Gotik",
                        color: Colors.white
                      ),
                    ),
                  ),
                  Text(
                    " -\t Continue?",
                    style: TextStyle(
                      fontFamily: "Gotik",
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              onPressed: () {
                if (currentOrder.total < 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          )
                      ),
                      content: Text(
                        "Amount must be \$ 10.00 or higher",
                        style: TextStyle(
                            fontFamily: 'Sans'
                        ),
                      )
                    )
                  );
                }
                else {
                  print('client search');
                  Navigator.pushReplacementNamed(context, '/client_search');
                }
              },
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cartAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            addCommission(),
            SizedBox(height: 10),
            addTransactionFee(),
            SizedBox(height: 5),
            productsTitle(),
            displayList(), // builder to show all items
          ],
        )
      ),
      bottomNavigationBar: bottomConfirmBar()
    );
  }
}
