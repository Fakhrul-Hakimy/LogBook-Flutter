import 'package:flutter/material.dart';
import 'package:logbook/models/log_list.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController title = TextEditingController();
  TextEditingController comment = TextEditingController();

  void sendLog() async{
    String logTitle = title.text;
    String logComment = comment.text;

    if (logTitle.isEmpty || logComment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields"))
      );
      return;
    }
    
    LogList newLog = LogList(title: logTitle, comment: logComment, date: DateTime.now().toIso8601String());

    List <LogList> logs = await getLogs();

    logs.add(newLog);
    await saveLogs(logs);


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Log submitted successfully!"))
    );
    title.clear();
    comment.clear();
  }

   Future<void> saveLogs(List<LogList> logs) async {
      final prefs = await SharedPreferences.getInstance();
      List<String> jsonList = logs.map((log) => jsonEncode(log.toJson())).toList();
      await prefs.setStringList('logs', jsonList);
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
      body : Center(
        child: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              TextField(controller: title,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter title...',
              ),
              
              
              ),
              TextField(controller: comment,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter comment...',
              ),
              
              ),
              
              
              ElevatedButton(onPressed: sendLog, child: Text("Submit"))
            ],
          ),
        ),
        
        
      ),
    
    );
  }
}