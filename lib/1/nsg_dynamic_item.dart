import 'package:nsg_data/nsg_data.dart';

class NsgDynamicItem extends NsgDataItem {
  @override
  NsgDataItem getNewObject() {
    throw Exception('getNewObject for type {runtimeType} is not defined');
  }
}
