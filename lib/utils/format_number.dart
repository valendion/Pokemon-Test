String addDigit(int number) {
  var image = number.toString().padLeft(3, '0');
  return "$image.png";
}

String getNumberImage(String text) {
  var oldText = text.substring(34);
  var resultText = oldText.substring(0, oldText.length - 1);
  return resultText;
}
