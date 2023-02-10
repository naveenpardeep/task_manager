abstract class Helper {
  static imageUri(String name) {
    if (name.isEmpty) {
      return 'http://alex.nsgsoft.ru:8893/no_photo.jpg';
    }

    return 'http://alex.nsgsoft.ru:8893/$name';
  }
}
