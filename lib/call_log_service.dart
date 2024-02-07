import 'package:call_log/call_log.dart';

class CallLogService {
  Future<List<CallLogEntry>> getCallLog() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries.toList();
  }
}
