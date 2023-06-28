import 'generated/business_process.g.dart';

class BusinessProcess extends BusinessProcessGenerated {
   @override
  String toString() {
    return statusFrom.name.toString();
  }
}