import 'dart:collection';

import 'package:alta_pos/models/cart.dart';
import 'package:alta_pos/models/order.dart';
import 'package:alta_pos/models/profile.dart';

enum PaymentMethod {QR, Credit_Card, Cash}

late String _link;

Order CURRENT_ORDER = new Order(
    null, new Cart(new SplayTreeMap()), null);

Profile USER_PROFILE = new Profile(
    'Mark Codd', 'codd82@gmail.edu', 'macodd', 'gkdagkasd56273mk');

void buildLink(username, transactionId) =>
    _link = 'https://www.zitio.io/pay/$username/$transactionId/';


String getLink() => _link;