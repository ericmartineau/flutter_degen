class ComplexArgs {
  final String arg1;
  final String arg2;
  final double arg3;

  ComplexArgs(this.arg1, this.arg2, this.arg3);

  List<String> getAll(String rich, {double farce}) {
    return [rich, arg1, arg2];
  }
}
