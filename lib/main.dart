import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils/style.dart';

/// Screens
import 'utils/loading.dart';
import 'screens/login/login_screen.dart';
import 'screens/reset_password/reset_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/products/products_list_screen.dart';
import 'screens/client_search/client_search_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/payment_select/payment_select_screen.dart';
import 'screens/success/success_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AltaApp());
}

class AltaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// Only allowed portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Alta app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: ColorStyle.background,
          backgroundColor: ColorStyle.blackBackground,
          dividerColor: ColorStyle.iconColorDark,
          accentColor: ColorStyle.primaryColor,
          primaryColor: ColorStyle.primaryColor,
          hintColor: ColorStyle.fontSecondaryColorDark,
          buttonColor: ColorStyle.primaryColor,
          canvasColor: ColorStyle.grayBackground,
          cardColor: ColorStyle.grayBackground,
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: ColorStyle.fontColorDark,
            selectionHandleColor: ColorStyle.fontColorDarkTitle,
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/forgot': (context) => ForgotPasswordScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/products' : (context) => ProductsListScreen(),
        '/cart' : (context) => CartScreen(),
        '/client_search' : (context) => ClientSearchScreen(),
        '/payment_select' : (context) => PaymentSelectScreen(),
        '/complete' : (context) => SuccessScreen(),
      },
    );
  }
}
