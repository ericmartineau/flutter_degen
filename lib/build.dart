import 'package:build/build.dart';
import 'package:flutter_degen/src/degenerator.dart';
import 'package:source_gen/source_gen.dart';

Builder degenBuilder(BuilderOptions options) =>
    SharedPartBuilder([DelegateGenerator()], 'degen');
