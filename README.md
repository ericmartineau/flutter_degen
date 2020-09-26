Generates property delegates within classes.

```
import 'package:flutter_degen/annotations.dart';

class OtherType {
  final String greeting;

  OtherType(this.greeting);
}

class TypeWithDelegate with _OtherTypeMixin {
  @delegate(implementDelegate=true)
  final OtherType _otherType;

  TypeWithDelegate(this._otherType); 
}

/// After generation, you can do this:
final typeWithDelegate = TypeWithDelegate(OtherType("Hello, world"));
assert(typeWithDelegate is OtherType);  
assert(typeWithDelegate.greeting == "Hello, world");
```