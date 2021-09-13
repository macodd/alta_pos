import 'dart:collection';

import 'package:alta_pos/models/cart.dart';
import 'package:alta_pos/models/order.dart';
import 'package:alta_pos/models/profile.dart';


Profile? userProfile;

Order currentOrder = new Order(
    null, new Cart(new SplayTreeMap()), null);

String buildLink() =>
    'https://pay.zitio.io/gateway/${userProfile!.uid}/${currentOrder.getTransactionId()}/';


