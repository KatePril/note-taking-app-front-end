import 'package:flutter/material.dart';

class OffsetsParser {
  OffsetsParser._internal();

  static final OffsetsParser _instance = OffsetsParser._internal();

  factory OffsetsParser() {
    return _instance;
  }

  static String parseOffsets(List<Offset?> offsets) {
    return '[${offsets.map((offset) {
      if (offset != null) {
        return '(${offset.dx}, ${offset.dy})';
      } else {
        return '(null, null)';
      }
    }).join(', ')}]';
  }

  static List<Offset?> parseString(String str) {
    List<String> pairs = str.substring(2, str.length - 2).split('), (');

    return pairs.map((pair) {
      var coords = pair.split(', ');
      if (coords.length == 2) {
        try {
          var x = coords[0] == 'null' ? null : double.tryParse(coords[0]);
          var y = coords[1] == 'null' ? null : double.tryParse(coords[1]);

          if (x != null && y != null) {
            return Offset(x, y);
          } else {
            return null;
          }
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
    }).toList();
  }

}