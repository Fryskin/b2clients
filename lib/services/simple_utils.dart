import 'dart:math';

class SimpleUtils {
  String toTitleCase(String word) {
    word =
        word.replaceFirst(word[0], word[0].toUpperCase()).replaceAll('_', ' ');

    return word;
  }

  int generateRandomInt() {
    int randomInt = Random().nextInt(100000);
    return randomInt;
  }
}
