import 'dart:convert' as converter;
import 'package:crudapp/ModelCrud.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  DateTime now = DateTime.now();
  List<ModelCrud> task = [];

  sendDataToApi(String name, String age) async {
    final body = {
      "name": name,
      "age": age,
    };
    var url =
        "https://crudcrud.com/api/53ffa738fd394f199562da85a86dfeb2/unicorns";
    final uri = Uri.parse(url);
    var response = await http.post(
      uri,
      body: converter.jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      print('Creation Success');
    } else {
      print("Creation Failed");
    }
  }

  Future<List<ModelCrud>> getApi() async {
    var url = Uri.parse(
        "https://crudcrud.com/api/53ffa738fd394f199562da85a86dfeb2/unicorns");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = converter.jsonDecode(response.body);
      var eachMap;
      for (eachMap in responseBody) {
        task.add(ModelCrud.fromJson(eachMap));
      }
    } else {
      print("Failed to load data");
    }
    return task;
  }

  updatebyid(String id, String name, String age) async {
    final body = {
      "name": name,
      "age": age,
    };
    final url =
        'https://crudcrud.com/api/53ffa738fd394f199562da85a86dfeb2/unicorns/$id';
    final uri = Uri.parse(url);
    var response = await http.put(
      uri,
      body: converter.jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      print('Creation Success');
    } else {
      print("Creation Failed");
    }
  }

  deleteById(String id) async {
    final url =
        'https://crudcrud.com/api/53ffa738fd394f199562da85a86dfeb2/unicorns/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    await http.delete(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getApi(),
        builder: (context, AsyncSnapshot<List<ModelCrud>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.blueGrey,
                  leading: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                  title:
                      Text(snapshot.data![index].name.toString() ?? "No name"),
                  subtitle: Row(
                    children: [
                      Text("${snapshot.data![index].age.toString()} years" ??
                          "No age"),
                      Text(' ${now.day}-${now.month}-${now.year}'),
                    ],
                  ),
                  trailing: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await deleteById(snapshot.data?[index].sId ?? 0);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                          onPressed: () async {
                            await updatebyid(snapshot.data?[index].sId ?? 0);
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "No data available",
                style: TextStyle(color: Colors.black),
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
                    onPressed: () async {
                      String name = nameController.text;
                      String age = ageController.text;
                      sendDataToApi(name, age);
                      setState(() {
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
        child: const Text("Add",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
