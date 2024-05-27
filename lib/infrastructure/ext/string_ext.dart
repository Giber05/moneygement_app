extension IntParsing on String {
  int parseCurrencyToInt() {
    String stringWithoutCurrency =
        replaceAll('Rp. ', '').replaceAll('.', '');

    // Parse the string to int
    int parsedNumber = int.tryParse(stringWithoutCurrency) ?? 0;
    return parsedNumber;
  }
}
