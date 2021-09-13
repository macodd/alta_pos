import 'package:alta_pos/components/app_bar.dart';
// import 'package:alta_pos/examples/example_objects.dart';
import 'package:alta_pos/screens/price_confirm/price_confirm_screen.dart';

import 'package:alta_pos/models/product.dart';

// import 'package:alta_pos/utils/firestore_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ProductsListScreen extends StatefulWidget {
  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> with TickerProviderStateMixin {

  final Stream<QuerySnapshot> _productStream = FirebaseFirestore
      .instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('products')
      .snapshots();

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2)
    )..addListener(() {
      setState(() {});
    });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       child: Scaffold(
         appBar: generalAppBar(context, 'Products'),
         body: Container(
           padding: const EdgeInsets.symmetric(horizontal: 14),
           child: StreamBuilder<QuerySnapshot>(
               stream: _productStream,
               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.hasError) {
                   return Center(
                     child: Text('Something went wrong')
                   );
                 }

                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return Center(
                     child: CircularProgressIndicator(
                       value: controller.value,
                       semanticsLabel: 'Loading..',
                     ),
                   );
                 }

                 return ListView(
                   padding: const EdgeInsets.only(top: 10, bottom: 100),
                   children: snapshot.data!.docs.map((DocumentSnapshot document) {
                     Product product = Product.fromJson(document.data());
                     return Card(
                       child: ListTile(
                         isThreeLine: true,
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
                         trailing: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               product.initialPrice.toStringAsFixed(2),
                               style: TextStyle(
                                   fontFamily: "Popins",
                                   fontSize: 16
                               ),
                             ),
                           ],
                         )
                       ),
                     );
                   }).toList(),
                 );
               }
           )
         )
       ),
       onWillPop: () async => false
     );
  }
}
