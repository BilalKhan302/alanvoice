import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
void main(){
  runApp(MyCustomForm());
}
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {

    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();
  MyCustomFormState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton("77b9cf3440f53583a32f9e606194fa102e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command)=>_handleCommand(command.data));
  }
  final namController=TextEditingController();
  final addressController=TextEditingController();
  final phoneController=TextEditingController();
  void _handleCommand(Map<String, dynamic> command){
    switch(command['command']){
      case'getName':
        namController.text=command["text"];
        break;
      case 'getAddress':
        addressController.text=command["text"];
        break;
      case 'getNumber':
        phoneController.text=command["text"];
        break;
      default:
        debugPrint("unknown command");
    }
  }

  @override
  void dispose(){
    namController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
         body:  Form(
           key: _formKey,
           child: Padding(
             padding: const EdgeInsets.all(30),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 // Add TextFormFields and ElevatedButton here.
                 TextFormField(
                   controller: namController,
                   decoration: InputDecoration(
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15)
                     ),
                     label: Text("Enter your name")
                   ),
                   // The validator receives the text that the user has entered.
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter some text';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 10,),
                 TextFormField(
                   controller: addressController,
                   decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15)
                       ),
                       label: Text("Enter your Address")
                   ),
                   // The validator receives the text that the user has entered.
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter some text';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 10,),
                 TextFormField(
                   keyboardType: TextInputType.number,
                   controller: phoneController,
                   // The validator receives the text that the user has entered.
                   decoration: InputDecoration(

                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15)
                       ),
                       label: Text("Enter your phone no")
                   ),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter some text';
                     }
                     return null;
                   },
                 ),
                 SizedBox(height: 10,),
                 ElevatedButton(
                   onPressed: () {
                     // Validate returns true if the form is valid, or false otherwise.
                     if (_formKey.currentState!.validate()) {
                       // If the form is valid, display a snackbar. In the real world,
                       // you'd often call a server or save the information in a database.
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text('Processing Data')),
                       );
                     }
                   },
                   child: const Text('Submit'),
                 ),
               ],
             ),
           ),
         ),
        ),
      )

    );
  }
}
