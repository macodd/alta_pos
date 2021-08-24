import 'package:alta_pos/models/product.dart';

import '../models/client.dart';
import '../models/product.dart';


/// ExampleCustomer
Client CUSTOMER =
  new Client(
      "0924749146",
      "John",
      "Doe",
      "john_doe@mail.com"
  );

void setAddress() {
  CUSTOMER.setAddress(new Address("Oakland", "CA", "Valdez", "Webster"));
}


// search function based on customer id
Client? searchCustomer(String clientID) {
  if (clientID == CUSTOMER.ruc) {
    setAddress();
    return CUSTOMER;
  }
  return null;
}

List<Product> PRODUCTS = [
  Product("Budweiser", "sku000", "American-style Lager", "Beer", 5.99),
  Product("Corona", "sku001", "Even-keeled cerveza", "Beer", 5.99),
  Product("Heineken", "sku003", "Beer. Made Better", "Beer", 6.99),
  Product("Stella", "sku002", "Best-selling Belgian beer", "Beer", 6.99),
  Product("Drake's", "sku004", "Hold my Hopoc", "Beer", 7.99)
];


String firebaseGetUid() {
  return 'AXW23T';
}