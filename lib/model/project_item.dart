import 'generated/project_item.g.dart';

class ProjectItem extends ProjectItemGenerated {
  @override
  bool isFieldRequired(String fieldName) {
    return (fieldName == ProjectItemGenerated.nameOrganizationId);
  }
}
