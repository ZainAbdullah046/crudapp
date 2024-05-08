import 'dart:convert' as converter;
import 'package:crudapp/ModelCrud.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class todo extends StatefulWidget {
  const todo({Key? key}) : super(key: key);

  @override
  State<todo> createState() => _TodoState();
}

class _TodoState extends State<todo> {
  List<ModelCrud> task = [];

  Future<List<ModelCrud>> getPostapi() async {
    var url = Uri.parse(
        "https://crudcrud.com/api/a1c5014e53294f12b926bbfddc21c83d/unicorns");
    var response = await http.get(url);
    var responseBody = converter.jsonDecode(response.body); // Fixed typo here
    var eachmap;
    for (eachmap in responseBody) {
      task.add(ModelCrud.fromJson(eachmap));
    }
    return task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPostapi(),
        builder: (context, AsyncSnapshot<List<ModelCrud>> snapshot) {
          if (snapshot.hasData) {
            // Fixed typo here
            return ListView.builder(
              itemCount: snapshot.data!.length, // Fixed typo here
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].taskName.toString() ??
                      "no taskname"), // Fixed typo here
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
