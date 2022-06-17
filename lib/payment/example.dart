// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:awesome_card/awesome_card.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Awesome Credit Card Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Awesome Credit Card Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String cardNumber = '';
//   String cardHolderName = '';
//   String expiryDate = '';
//   String cvv = '';
//   bool showBack = false;

//   late FocusNode _focusNode;
//   TextEditingController cardNumberCtrl = TextEditingController();
//   TextEditingController expiryFieldCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//     _focusNode.addListener(() {
//       setState(() {
//         _focusNode.hasFocus ? showBack = true : showBack = false;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 40,
//             ),
//             CreditCard(
//               cardNumber: cardNumber,
//               cardExpiry: expiryDate,
//               cardHolderName: cardHolderName,
//               cvv: cvv,
//               bankName: 'Axis Bank',
//               showBackSide: showBack,
//               frontBackground: CardBackgrounds.black,
//               backBackground: CardBackgrounds.white,
//               showShadow: true,
//               // mask: getCardTypeMask(cardType: CardType.americanExpress),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: TextFormField(
//                     controller: cardNumberCtrl,
//                     decoration: InputDecoration(hintText: 'Card Number'),
//                     maxLength: 16,
//                     onChanged: (value) {
//                       final newCardNumber = value.trim();
//                       var newStr = '';
//                       final step = 4;

//                       for (var i = 0; i < newCardNumber.length; i += step) {
//                         newStr += newCardNumber.substring(
//                             i, math.min(i + step, newCardNumber.length));
//                         if (i + step < newCardNumber.length) newStr += ' ';
//                       }

//                       setState(() {
//                         cardNumber = newStr;
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: TextFormField(
//                     controller: expiryFieldCtrl,
//                     decoration: InputDecoration(hintText: 'Card Expiry'),
//                     maxLength: 5,
//                     onChanged: (value) {
//                       var newDateValue = value.trim();
//                       final isPressingBackspace =
//                           expiryDate.length > newDateValue.length;
//                       final containsSlash = newDateValue.contains('/');

//                       if (newDateValue.length >= 2 &&
//                           !containsSlash &&
//                           !isPressingBackspace) {
//                         newDateValue = newDateValue.substring(0, 2) +
//                             '/' +
//                             newDateValue.substring(2);
//                       }
//                       setState(() {
//                         expiryFieldCtrl.text = newDateValue;
//                         expiryFieldCtrl.selection = TextSelection.fromPosition(
//                             TextPosition(offset: newDateValue.length));
//                         expiryDate = newDateValue;
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: TextFormField(
//                     decoration: InputDecoration(hintText: 'Card Holder Name'),
//                     onChanged: (value) {
//                       setState(() {
//                         cardHolderName = value;
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//                   child: TextFormField(
//                     decoration: InputDecoration(hintText: 'CVV'),
//                     maxLength: 3,
//                     onChanged: (value) {
//                       setState(() {
//                         cvv = value;
//                       });
//                     },
//                     focusNode: _focusNode,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
  
//     );


   
//   }



import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}




