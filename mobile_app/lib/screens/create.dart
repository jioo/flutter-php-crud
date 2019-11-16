import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';

class Create extends StatefulWidget {
  final Function refreshStudentList;

  Create({this.refreshStudentList});

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  // Required for form validations
  final _formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  // Http post request to create new data
  Future _createStudent() async {
    return await http.post(
      "${Env.URL_PREFIX}/create.php",
      body: {
        "name": nameController.text,
        "age": ageController.text,
      },
    );
  }

  void _onConfirm(context) async {
    await _createStudent();

    // Remove all existing routes until the Home.dart, then rebuild Home.
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  String validateName(String value) {
    if (value.length < 3) return 'Name must be more than 2 charater';
    return null;
  }

  String validateAge(String value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Age must be a number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text("CONFIRM"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: validateName,
                  ),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Age'),
                    validator: validateAge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
