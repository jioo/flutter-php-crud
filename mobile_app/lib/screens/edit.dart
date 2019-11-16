import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/Student.dart';

class Edit extends StatefulWidget {
  final Student student;

  Edit({this.student});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  // Required for form validations
  final _formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController;
  TextEditingController ageController;

  // Http post request to update data
  Future editStudent() async {
    return await http.post(
      "${Env.URL_PREFIX}/update.php",
      body: {
        "id": widget.student.id.toString(),
        "name": nameController.text,
        "age": ageController.text
      },
    );
  }

  void _onConfirm(context) {
    editStudent();

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
  void initState() {
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text('CONFIRM'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            _onConfirm(context);
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
