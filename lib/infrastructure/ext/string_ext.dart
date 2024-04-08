extension IntParsing on String {
  int parseCurrencyToInt() {
    // Remove currency symbol and commas from the string
    String stringWithoutCurrency =
        this.replaceAll('Rp. ', '').replaceAll('.', '');

    // Parse the string to int
    int parsedNumber = int.tryParse(stringWithoutCurrency) ?? 0;
    return parsedNumber;
  }
}
