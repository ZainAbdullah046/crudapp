import 'dart:convert';
import 'package:crudapp/ModelCrud.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class todo extends StatefulWidget {
  const todo({super.key});

  @override
  State<todo> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<todo> {
  getPostapi() async {
    var url = Uri.parse(
        "https://crudcrud.com/api/a1c5014e53294f12b926bbfddc21c83d/unicorns");
    var response = await http.get(url);
    var responseBody = jasonDecode(response.Body);
    return ModelCrud.fromJson(responseBody);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
