import 'generated/task_doc.g.dart';

class TaskDoc extends TaskDocGenerated {
  TaskDoc() {
    newTableLogic = true;
  }
  
  @override
  bool isFieldRequired(String fieldName) {
    return fieldName == TaskDocGenerated.nameProjectId ||
        fieldName == TaskDocGenerated.nameTaskStatusId;
  }
 
}
