import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../env.dart';
import '../models/Student.dart';
import './details.dart';
import './create.dart';

Future<List<Student>> getStudentList() async {
  final response = await http.get("${Env.URL_PREFIX}/list.php");

  // var jsonData = json.decode(response.body);
  // List<Student> students = jsonData.map((Map model) => Student.fromJson(model)).toList();
  // return students;

  var jsonData = json.decode(response.body);
  List<Student> students = [];
  for (var data in jsonData) {
    students.add(Student.fromJson(data));
  }

  return students;
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List<Student>> students;
  final studentListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      students = getStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Center(
        child: FutureBuilder<List<Student>>(
          future: students,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();

            // Render student lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return ListTile(
                  title: Text(data.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return Details(student: data);
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Create();
          }));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
