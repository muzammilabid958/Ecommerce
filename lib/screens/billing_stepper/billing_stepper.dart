import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MakkiHerb/constant/api_services.dart';
import 'package:MakkiHerb/models/FetchAddress.dart';
import 'package:MakkiHerb/models/FetchAddress.dart' as fetchaddress;
import 'package:searchable_dropdown/searchable_dropdown.dart';

class BillingStepper extends StatefulWidget {
  BillingStepper({Key? key}) : super(key: key);
  @override
  _BillingStepperState createState() => _BillingStepperState();
}

class _BillingStepperState extends State<BillingStepper> {
  int currentStep = 0;
  FetchAddress address = new FetchAddress(data: []);
  List<Data> city = [];
  getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString("loggedIntoken").toString();

    dynamic data = await APIService.getAddress(token);
    print(data);
    setState(() {
      address = new FetchAddress.fromJson(data);
      city = address.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Stepper"),
      ),
      body: Stepper(
        steps: getSteps(),
        currentStep: currentStep,
        onStepTapped: (int step) {
          setState(() {
            currentStep = step;
          });
        },
        onStepCancel: () {
          currentStep > 0 ? setState(() => currentStep -= 1) : null;
        },
        onStepContinue: () {
          currentStep < 2 ? setState(() => currentStep += 1) : null;
        },
      ),
    );
  }

  late fetchaddress.Data _selectedLocation;
  List<Step> getSteps() {
    return [
      Step(
        title: new Text('Personal Info'),
        content: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(
                  height: 14,
                ),
                Center(
                  child: DropdownButton(
                    hint: Text(
                        'Please choose a location'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {});
                    },
                    items: address.data.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location.city),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
        isActive: currentStep >= 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: new Text('Address Details'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Home Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mobile No'),
            ),
          ],
        ),
        isActive: currentStep >= 1,
        state: currentStep == 1
            ? StepState.editing
            : currentStep < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text("Bank Details"),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Account No'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'IFSC Code'),
            ),
          ],
        ),
        isActive: currentStep >= 2,
        state: currentStep == 2
            ? StepState.editing
            : currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }
}
