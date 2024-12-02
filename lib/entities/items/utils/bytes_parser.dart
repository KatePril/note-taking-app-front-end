import 'dart:typed_data';

class BytesParser {
  BytesParser._internal();

  static final BytesParser _instance = BytesParser._internal();

  factory BytesParser() {
    return _instance;
  }

  static Uint8List parseString(String str) {
    List<String> stringNumbers = str.substring(1, str.length - 1).split(', ');
    List<int> intList = stringNumbers.map(int.parse).toList();

    return Uint8List.fromList(intList);
  }
}