import 'generated/user_account.g.dart';

class UserAccount extends UserAccountGenerated {
  @override
  String toString() {
    if (organization.isNotEmpty) {
      return '${super.toString()} - ${organization.name}';
    }
    return super.toString();
  }
}
