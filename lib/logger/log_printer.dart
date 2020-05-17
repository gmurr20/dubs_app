import 'package:logger/logger.dart';

// Custom log printer that adds the class name
class SimpleLogPrinter extends LogPrinter {
  final String className;
  final PrettyPrinter usePrettyPrinter = PrettyPrinter();
  SimpleLogPrinter(this.className);
  @override
  List<String> log(LogEvent event) {
    LogEvent newEvent = LogEvent(event.level, className + ": " + event.message,
        event.error, event.stackTrace);
    return usePrettyPrinter.log(newEvent);
  }
}

// used to instantiate a class logger
Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
