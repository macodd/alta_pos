import 'package:alta_pos/components/app_bar.dart';
import 'package:alta_pos/screens/client_info/client_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alta_pos/models/client.dart';


class ClientCreateScreen extends StatefulWidget {
  ClientCreateScreen({key, required this.title, this.customer}) : super(key: key);

  final String title;
  final Client? customer;

  @override
  _ClientCreateScreenState createState() => _ClientCreateScreenState();
}

class _ClientCreateScreenState extends State<ClientCreateScreen> {

  final GlobalKey<FormState> _clientKey = new GlobalKey();
  final GlobalKey<FormState> _addressKey = new GlobalKey();

  final TextEditingController _rucController = new TextEditingController();
  final TextEditingController _firstNamesController = new TextEditingController();
  final TextEditingController _lastNamesController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _cityController = new TextEditingController();
  final TextEditingController _stateController = new TextEditingController();
  final TextEditingController _neighborhoodController = new TextEditingController();
  final TextEditingController _streetController = new TextEditingController();


  @override
  void initState() {
    if (widget.customer != null) {
      _rucController.text = widget.customer!.ruc;
      _firstNamesController.text = widget.customer!.firstNames;
      _lastNamesController.text = widget.customer!.lastNames;
      _emailController.text = widget.customer!.email;

      _cityController.text = widget.customer!.address!.city;
      _stateController.text = widget.customer!.address!.state;
      _neighborhoodController.text = widget.customer!.address!.neighborhood;
      _streetController.text = widget.customer!.address!.street;
    }
    super.initState();
  }

  @override
  void dispose() {
    _rucController.dispose();
    _firstNamesController.dispose();
    _lastNamesController.dispose();
    _emailController.dispose();

    _cityController.dispose();
    _stateController.dispose();
    _neighborhoodController.dispose();
    _streetController.dispose();

    super.dispose();
  }

  Widget _strTextField(label, _controller) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontFamily: "Popins",
          fontSize: 12
        ),
        labelText: label,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Field can't be empty";
        }
        return null;
      },
    );
  }

  Widget _numTextField(label, controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(13),
        ],
      decoration: InputDecoration(
        labelStyle: TextStyle(
            fontFamily: "Popins",
            fontSize: 12
        ),
        labelText: label,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Field can't be empty";
        }
        if (val.length == 10 || val.length == 13) {
          return null;
        }
        else {
          return 'Invalid length';
        }
      }
    );
  }

  Widget _clientInfoStep() {
    return Form(
      key: _clientKey,
      child: Column(
        children: [
          _numTextField('RUC', _rucController),
          _strTextField('Email', _emailController),
          _strTextField('First Names', _firstNamesController),
          _strTextField('Last Names', _lastNamesController),
        ],
      )
    );
  }

  Widget _clientAddressStep() {
    return Form(
      key: _addressKey,
      child: Column(
        children: [
          _strTextField('city', _cityController),
          _strTextField('state', _stateController),
          _strTextField('neighborhood', _neighborhoodController),
          _strTextField('street', _streetController),
        ],
      )
    );
  }

  late Client currentClient;

  void next() {
    switch (_index) {
      case 0:
        if (_clientKey.currentState!.validate()) {
          setState(() {
            _activeInfo = false;
            _activeAddress = true;
            _infoState = StepState.complete;

            currentClient = new Client(
                _rucController.text,
                _firstNamesController.text,
                _lastNamesController.text,
                _emailController.text,
            );
          });
          goto(1);
        }
        else {
          setState(() {
            _infoState = StepState.error;
          });
        }
        break;
      case 1:
        if (_addressKey.currentState!.validate()) {
          setState(() {
            _addressState = StepState.complete;

            currentClient.setAddress(new Address(
              _cityController.text,
              _stateController.text,
              _neighborhoodController.text,
              _streetController.text,
            ));
          });
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClientInfoPage(customer: currentClient)
              )
          );
        }
        else {
          setState(() {
            _addressState = StepState.error;
          });
        }
        break;
    }
  }

  void cancel() {
    switch (_index) {
      case 0:
        setState(() {
          complete = false;
        });
        break;
      case 1:
        setState(() {
          _activeAddress = false;
          _activeInfo = true;
          _addressState = StepState.editing;
          complete = false;
        });
        goto(0);
        break;
    }
  }

  void goto(int index) {
    setState(() => _index = index );
  }

  int _index = 0;
  bool complete = false;

  bool _activeInfo = true;
  bool _activeAddress = false;

  StepState _infoState = StepState.editing;
  StepState _addressState = StepState.editing;

  Step _stepController(label, isActive, stepState, child) {
    return Step(
      title: label,
      isActive: isActive,
      state: stepState,
      content: Container(
        alignment: Alignment.centerLeft,
        child: child
      ),
    );
  }

  Widget _controlBuilder(BuildContext context, { VoidCallback? onStepContinue, VoidCallback? onStepCancel }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: onStepContinue,
        child: const Text(
          'NEXT',
          style: TextStyle(
            fontFamily: "Gotik",
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, widget.title),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              controlsBuilder: _controlBuilder,
              currentStep: _index,
              onStepCancel: cancel,
              onStepContinue: next,
              onStepTapped: goto,
              steps: <Step>[
                _stepController(const Text('Info'), _activeInfo, _infoState, _clientInfoStep()),
                _stepController(const Text('Address'), _activeAddress, _addressState, _clientAddressStep()),
              ],
            )
          ),
        ],
      )
    );
  }
}