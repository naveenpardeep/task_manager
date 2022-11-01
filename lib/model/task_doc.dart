import 'generated/task_doc.g.dart';

class TaskDoc extends TaskDocGenerated {
  @override
  bool isFieldRequired(String fieldName) {
    return fieldName == TaskDocGenerated.nameProjectId;
  }
}
