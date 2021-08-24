import 'package:alta_pos/components/app_bar.dart';
import 'package:alta_pos/examples/example_objects.dart';
import 'package:alta_pos/models/client.dart';
import 'package:alta_pos/screens/client_create/client_create_screen.dart';
import 'package:alta_pos/utils/order_setup.dart';
import 'package:alta_pos/utils/style.dart';
import 'package:flutter/material.dart';


class ClientInfoPage extends StatelessWidget {
  ClientInfoPage({key, required this.customer}) : super(key: key);

  // customer information to show to user
  final Client customer;

  // General build widget to show information
  Widget customerInfo(label, customerInfo) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: "Popins",
          fontSize: 12,
          color: Colors.grey
        )
      ),
      subtitle: Text(
        customerInfo,
        style: TextStyle(
          fontFamily: "Popins",
          fontSize: 16,
          color: Colors.white
        )
      ),
    );
  }

  Widget editButton(context) {
    return FloatingActionButton(
      heroTag: "edit",
      tooltip: "Edit user",
      backgroundColor: Colors.blueGrey,
      child: Icon(Icons.edit_outlined, color: Colors.white),
      onPressed: () {
        print('edit customer');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClientCreateScreen(
              title: "Update Client",
              customer: customer,
            )
          )
        );
      }
    );
  }

  Widget nextButton(context) {
    return FloatingActionButton(
        heroTag: "continue",
        tooltip: "Continue",
        backgroundColor: ColorStyle.primaryColor,
        child: Icon(Icons.arrow_forward, color: Colors.white),
        onPressed: () {
          print('payment type');
          CURRENT_ORDER.setClient(customer);
          String fbUid = firebaseGetUid();
          CURRENT_ORDER.setTransactionId(fbUid);
          buildLink(USER_PROFILE.getUsername(), fbUid);
          Navigator.pushNamed(context, '/payment_select');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, 'Client'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 10),
          customerInfo("RUC", customer.ruc),
          customerInfo("First Names", customer.firstNames),
          customerInfo("Last Names", customer.lastNames),
          customerInfo("Email", customer.email),
          customerInfo("Address", '${customer.address!.street}, ${customer.address!.neighborhood}'),
          customerInfo("City", '${customer.address!.city}, ${customer.address!.state}'),
          SizedBox(height: 100),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          editButton(context),
          SizedBox(height: 20),
          nextButton(context),
        ],
      )
    );
  }
}
