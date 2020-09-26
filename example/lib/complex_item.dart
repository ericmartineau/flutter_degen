import 'package:flutter_degen_annotations/flutter_degen_annotations.dart';

import 'complex_args.dart';
part 'complex_item.g.dart';

class ComplexItem with _ComplexArgsMixin {
  @delegate()
  final ComplexArgs _complexArgs;

  ComplexItem(this._complexArgs);
}
