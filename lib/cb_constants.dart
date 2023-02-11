class CBConstants {
  static const String fullZPattern = "yyyy-MM-dd'T'HH:mm:ss'Z'";
  static const String fullPattern = "yyyy-MM-dd'T'HH:mm:ss";
  static const String backPattern = "yyyy-MM-dd";

  RegExp acceptableNameChars = RegExp(r'^[a-zA-Zа-яА-Я әғқңөұүhіӘҒҚҢӨҰҮҺІ-]+$');
}
