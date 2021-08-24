import 'package:alta_pos/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:alta_pos/utils/order_setup.dart';


class PaymentSelectScreen extends StatefulWidget {
  
  final String link = getLink();
  final double orderTotal = CURRENT_ORDER.getTotal();

  @override
  _PaymentSelectScreenState createState() => _PaymentSelectScreenState();
}


class _PaymentSelectScreenState extends State<PaymentSelectScreen> {

  TextEditingController _controller = new TextEditingController();

  double _change = 0.0;
  double _displayAmount = 0.00;

  @override
  void initState() {
    super.initState();
  }

  PreferredSizeWidget paymentAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: TabBar(
        onTap: (idx) {
          FocusScope.of(context).unfocus();
        },
        labelColor: Colors.white,
        indicatorColor: Color(0xFF45C2DA),
        tabs: [
          Tab(
            icon: Icon(Icons.qr_code_outlined),
            child: Text(
              'QR code',
              style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 10
              ),
            ),
          ),
          Tab(
            icon: Icon(Icons.attach_money_outlined),
            child: Text(
              'Cash',
              style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 10
              ),
            ),
          ),
        ]
      ),
      title: Text(
        'Payment',
        style: TextStyle(
            fontFamily: "Sans",
            fontWeight: FontWeight.w600,
            fontSize: 18.5,
            color: Colors.white
        ),
      ),
      centerTitle: true,
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            CURRENT_ORDER.clear();
            Navigator.pushReplacementNamed(context, '/complete');
          },
          child: Text(
            'Done',
            style: TextStyle(
              fontFamily: 'Sans'
            ),
          )
        )
      ],
    );
  }

  Widget contentQRWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: RepaintBoundary(
                child: QrImage(
                  data: widget.link,
                  version: QrVersions.auto,
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                  errorCorrectionLevel: QrErrorCorrectLevel.L,
                  size: 0.42 * bodyHeight,
                  )
              )
            )
          )
        ],
      ),
    );
  }

  Widget displayAmount() {
    return Card(
      elevation: 10.0,
      color: ColorStyle.primaryColor,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "\$ " + _displayAmount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Sans",
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      )
    );
  }

  Widget amountInput() {
    return Opacity(
      opacity: 0.0,
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: TextFormField(
          autofocus: true,
          controller: _controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          onChanged: (val) {
            int? amount = int.tryParse(val);
            double total = CURRENT_ORDER.getTotal();
            double returnChange = 0.0;
            if (amount != null){
              double tmp = amount/100;
              if (tmp > total) {
                returnChange = tmp - total;
              }
              else {
                returnChange = 0.0;
              }
              setState(() {
                _displayAmount = tmp;
                _change = returnChange;
              });
            }
            else {
              setState(() {
                _displayAmount = 0.0;
              });
            }
          },
        )
      )
    );
  }

  Widget moneyCalculator() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Stack(
            fit: StackFit.loose,
            children: [
              // Shows amount in decimal form
              displayAmount(),
              // call to keyboard
              amountInput()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 14
                ),
              ),
              Text(
                CURRENT_ORDER.getTotal().toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 14
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change:',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 14
                ),
              ),
              Text(
                _change.toStringAsFixed(2),
                style: TextStyle(
                    fontFamily: "Popins",
                    fontSize: 14
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: paymentAppBar(),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  contentQRWidget(),
                  moneyCalculator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}