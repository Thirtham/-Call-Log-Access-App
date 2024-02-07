import 'package:flutter/material.dart';
import 'call_log_service.dart';
import 'package:call_log/call_log.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CallLogScreen(),
    );
  }
}

class CallLogScreen extends StatefulWidget {
  @override
  _CallLogScreenState createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  final CallLogService _callLogService = CallLogService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Log Access App'),
      ),
      body: FutureBuilder(
        future: _callLogService.getCallLog(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<CallLogEntry> callLog = snapshot.data as List<CallLogEntry>;
            return ListView.builder(
              itemCount: callLog.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(callLog[index].name ?? 'Unknown'),
                  subtitle: Text(
                      'Number: ${callLog[index].number}\nDuration: ${callLog[index].duration} seconds\nTime: ${callLog[index].timestamp}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
