import 'package:flutter/material.dart';
import 'package:logbook/models/log_list.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class listPage extends StatefulWidget {
  listPage({super.key});

  @override
  State<listPage> createState() => _listPageState();
}



class _listPageState extends State<listPage> {

  List<LogList> logs = [];
  int length = 0;

  @override
  void initState() {
    super.initState();
    loadLogs();
  }

  Future<void> loadLogs() async {
    logs = await getLogs();
    setState(() {
      length = logs.length;
    });
  }

  Future<List<LogList>> getLogs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('logs');
    if (jsonList == null) return [];
    return jsonList.map((jsonStr) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
      return LogList.fromJson(jsonMap);
    }).toList();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "LOG LIST",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )),
            
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(logs[index].title),
                    subtitle: Text(logs[index].comment),
                    trailing: Text(logs[index].date),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}