import 'generated/task_comment.g.dart';

class TaskComment extends TaskCommentGenerated {
   @override
  String toString() {
    return mainComment.text.toString();
  }
}