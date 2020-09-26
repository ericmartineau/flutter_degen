import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations.dart';
import 'field_annotation_generator.dart';

class DelegateGenerator extends GeneratorForAnnotatedField<delegate> {
  @override
  @override
  String generateForAnnotatedField(
      FieldElement field, ConstantReader annotation) {
    final includes = annotation.read('include').literalValue as List<String>;
    final excludes = annotation.read('exclude').literalValue as List<String>;
    final implementDelegate =
        annotation.read('implementDelegate').literalValue as bool;
    assert(!implementDelegate || (includes == null && excludes == null),
        "Implement delegate requires other param to be null");
    List<String> mixin = [];
    final fieldType = field.type;
    final parent = field.thisOrAncestorOfType<ClassElement>();

    final doesApply = (Element element) {
      if (includes != null) {
        return includes.contains(element.name);
      } else if (excludes != null) {
        return !excludes.contains(element.name);
      } else {
        return true;
      }
    };
    final fieldClass = fieldType.element as ClassElement;
    mixin += [
      "abstract class ${fieldType.element.name}Delegate {",
      "  ${fieldType.element.name} get ${field.name};",
      "}",
      "",
      "",
      "mixin _${fieldType.element.name}Mixin implements ${fieldType.element.name}Delegate${implementDelegate ? ', ${fieldType.element.name}' : ''} {",
      for (final dField in fieldClass.fields)
        if (doesApply(dField))
          "  ${dField.type} get ${dField.name} => ${field.name}.${dField.name};",
      for (final dMethod in fieldClass.methods)
        if (doesApply(dMethod)) delegateMethod(dMethod, field.name),
      "}",
    ];
    return mixin.join("\n");
  }

  String delegateMethod(MethodElement method, String delegateName) {
    var str = "  ${method.returnType} ${method.name}(";
    bool hitPositional = false;
    for (final p in method.parameters) {
      if (p.isNamed && !hitPositional) {
        str += "{";
        hitPositional = true;
      } else if (!p.isNamed && hitPositional) {
        hitPositional = false;
        str += "},";
      }
      str += "${p.type} ${p.name},";
    }
    if (hitPositional) {
      str += "}";
    } else {
      str = str.substring(0, str.length - 1);
    }

    str += ") => ${delegateName}.${method.name}(";
    for (final p in method.parameters) {
      if (p.isNamed) {
        str += "${p.name}: ${p.name},";
      } else {
        str += "${p.name},";
      }
    }
    str = str.substring(0, str.length - 1);
    str += ");";
    return str;
  }
}
