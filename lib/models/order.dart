import 'dart:collection';

import 'customer.dart';
import 'cart.dart';

enum PaymentMethod {QR, Credit_Card, Cash}


/// Order class
/// -----------
/// Stores the customer information and the Cart
class Order {
  // Customer holder
  Customer? _customer;
  // Cart holder
  Cart _cart;
  // payment type stored
  PaymentMethod? _paymentType;

  String? _transactionId;

  bool _addCommission = false;
  bool _transactionFee = false;

  Order(this._customer, this._cart, this._paymentType);

  Cart get cart => _cart;

  /// get it from firebase
  void setTransactionId(String transId) => _transactionId = transId;

  String? getTransactionId() => _transactionId;

  // updates the transaction fee
  void setTransactionFee() => _transactionFee = !_transactionFee;

  bool get transactionFee => _transactionFee;

  // updates the commission fee
  void setCommission() => _addCommission = !_addCommission;

  bool get commission => _addCommission;

  // return the total + 0.50 for transaction cost
  double get total {
    double transFee = 0.0;
    double commissionFee = 0.0;
    double total = _cart.getCartTotal();
    if (_transactionFee) {
      transFee = 0.5;
    }
    if (_addCommission) {
      commissionFee = total * 0.05;
    }
    return total + transFee + commissionFee;
  }

  // sets the payment type
  void setPaymentType(PaymentMethod pt) => _paymentType = pt;

  // gets the current payment type
  PaymentMethod? getPaymentMethod() => _paymentType;

  // sets a customer
  void setCustomer(Customer customer) => _customer = customer;

  // returns the customer
  Customer? getCustomer() => _customer;

  // clears the current order
  void clear() {
    _addCommission = false;
    _transactionFee = false;
    _customer = null;
    _cart = new Cart(new SplayTreeMap());
    _paymentType = null;
    _transactionId = null;
  }
}