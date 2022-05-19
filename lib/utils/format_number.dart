import 'dart:developer';

String addDigit(int number) {
  var image = number.toString().padLeft(3, '0');
  return "$image.png";
}

int getNumberImage(String text) {
  var oldText = text.substring(text.length - 2);
  var newText = oldText.replaceAll('/', '');
  log('NewText : $oldText');
  return int.parse(newText);
}
