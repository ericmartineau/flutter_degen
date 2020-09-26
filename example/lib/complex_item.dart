import 'package:flutter_degen/annotations.dart';

import 'complex_args.dart';
part 'complex_item.g.dart';

class ComplexItem with _ComplexArgsMixin {
  @delegate(implementDelegate: true)
  final ComplexArgs _complexArgs;

  ComplexItem(this._complexArgs);
}
