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
  DateTime now = DateTime.now();
  List<ModelCrud> task = [];

  Future<List<ModelCrud>> getPostapi() async {
    var url = Uri.parse(
        "https://crudcrud.com/api/53ffa738fd394f199562da85a86dfeb2/unicorns");
    var response = await http.get(url);
    var responseBody = converter.jsonDecode(response.body);
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
                  tileColor: Colors.blueGrey,
                  leading: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                  title:
                      Text(snapshot.data![index].name.toString() ?? "no name"),
                  subtitle: Row(
                    children: [
                      Text("${snapshot.data![index].age.toString()} years" ??
                          "no age"),
                      Text(' ${now.day}-${now.month}-${now.year}'),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "NOTHING TO SHOW ANY DATA",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController ageController = TextEditingController();
              return AlertDialog(
                title: const Text("Enter Your Details"),
                content: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                    TextField(
                      controller: ageController,
                      decoration: const InputDecoration(hintText: "Age"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        String name = nameController.text;
                        String age = ageController.text;
                        SendDatatoapi(name, age);
                        nameController.clear();
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Text(
          "Add",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
