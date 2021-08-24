import 'package:flutter/material.dart';


class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PreferredSizeWidget homeAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset("assets/icon/logo.png"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Icon(
            Icons.account_circle_outlined,
            color: Colors.white
          ),
        ),
      ],
    );
  }

  Widget homeScreenBody() {
    return Center(
      child: TextButton(
        child: Text('Start new order'),
        onPressed: () {
          Navigator.pushNamed(context, '/products');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: homeAppBar(),
        body: homeScreenBody(),
      ),
      onWillPop: () async => false
    );
  }
}
