import 'package:alta_pos/components/app_bar.dart';
import 'package:alta_pos/models/customer.dart';
import 'package:alta_pos/screens/client_create/client_create_screen.dart';
import 'package:alta_pos/screens/client_info/client_info_screen.dart';
import 'package:alta_pos/utils/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Search class that allows users to search the database
/// for previously registered customers.
class ClientSearchScreen extends StatefulWidget {
  @override
  _ClientSearchScreenState createState() => _ClientSearchScreenState();
}

/// Search class that allows users to search the database
/// for previously registered customers.
/// Stateful to show message of found/not found
class _ClientSearchScreenState extends State<ClientSearchScreen> {
  // search field editor
  final TextEditingController _searchField = TextEditingController();

  // form key
  final GlobalKey<FormState> _searchFormKey = new GlobalKey();

  // // widget to show if customer is found
  Widget? _showSearchResult;

  // used for changing focus after keyboard entry
  late FocusNode _focusNode;

  // create a new focus node
  @override
  void initState() {
    _focusNode = FocusNode();
    _showSearchResult = Text(
        'Search using the ruc',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.grey
      ),
    );
    super.initState();
  }

  // dispose of controller and focus node
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _searchField.dispose();
  }

  Widget searchForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _searchFormKey,
        child: TextFormField(
          controller: _searchField,
          focusNode: _focusNode,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_outlined),
              fillColor: Colors.transparent,
              hintText: "Search by ID",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20))),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(13)
          ],
          validator: (val) {
            // regex for only digits
            RegExp _digits = RegExp(r'^[0-9]+$');
            // validators
            if (val == null || val.isEmpty) {
              return "No id searched";
            }
            if ((val.length == 10 || val.length == 13) &&
                _digits.hasMatch(val)) {
              return null;
            }
            else {
              return 'Wrong format';
            }
          },
        ),
      )
    );
  }

  // widget to re route base on selection
  Widget searchButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorStyle.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 90),
        ),
        child: Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Gotik",
            fontSize: 16
          ),
        ),
        onPressed: () {
          _focusNode.unfocus();
          if (_searchFormKey.currentState!.validate()) {
            setState(() {
              _showSearchResult = searchCustomer();
            });
          }
        }
      );
  }

  FutureBuilder<DocumentSnapshot> searchCustomer() {
    CollectionReference customers = FirebaseFirestore.instance.collection('customers');
    
    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(_searchField.text).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Something went wrong")
            ]
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return showNoCustomerFound();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Customer customer = Customer.fromJson(snapshot.data!.id, snapshot.data!.data());
          return showFoundCustomer(customer);
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircularProgressIndicator(
              semanticsLabel: "searching..",
            )
          ]
        );
      },
    );
  }

  Widget showNoCustomerFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "No Customer Found",
            style: TextStyle(
              fontFamily: "Popins",
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClientCreateScreen(title: 'New Account')
                )
            );
          },
          child: Text('Add New Client')
        )
      ]
  );

  }

  /// shows the user if the customer is in the database
  Widget showFoundCustomer(Customer _customer) {
    // widget to store search result
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Customer Found",
            style: TextStyle(
              fontFamily: "Popins",
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          elevation: 10,
          color: ColorStyle.fontColorDarkTitle,
          child: InkWell(
            onTap: () {
              print('info page');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientInfoPage(customer: _customer)
                  )
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.person)),
                  title: Text(
                    _customer.fullName,
                    style: TextStyle(
                      fontFamily: 'Sans',
                      fontSize: 12
                    ),
                  ),
                  subtitle: Text(
                    _customer.ruc,
                    style: TextStyle(
                      fontFamily: 'Sans',
                      fontSize: 12
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, 'Search'),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            searchForm(),
            SizedBox(height: 16),
            searchButton(),
            SizedBox(height: 30),
            Container(
              child: _showSearchResult,
            ),
          ],
        ),
      ),
    );
  }
}
