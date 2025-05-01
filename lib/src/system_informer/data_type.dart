// ignore_for_file: constant_identifier_names

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'generated_bindings.dart';

// ignore: camel_case_types
typedef cVERIFY_RESULT = Int;

// ignore: camel_case_types
base class VERIFY_RESULT extends Struct {
  @Int()
  external int _value;
  VERIFYRESULT get value => VERIFYRESULT.values[_value];
}

/// replace ```
/// sealed class VERIFYRESULT {}
/// ```
/// in `generated_bindings.dart` with
/// ```dart
/// typedef VERIFYRESULT = data_type.VERIFYRESULT;
/// ```
enum VERIFYRESULT {
  VrUnknown(0),
  VrNoSignature(1),
  VrTrusted(2),
  VrExpired(3),
  VrRevoked(4),
  VrDistrust(5),
  VrSecuritySettings(6),
  VrBadSignature(7);

  final int value;
  const VERIFYRESULT(this.value);

  factory VERIFYRESULT.fromValue(int val) => VERIFYRESULT.values[val];
}

/// replace
/// ```
/// sealed class PH_SYMBOL_RESOLVE_LEVEL {}
/// ````
/// in `generated_bindings.dart` with
/// ```dart
/// typedef PH_SYMBOL_RESOLVE_LEVEL = data_type.PH_SYMBOL_RESOLVE_LEVEL;
/// ```
// ignore: camel_case_types
enum PH_SYMBOL_RESOLVE_LEVEL {
  PhsrlFunction(0),
  PhsrlModule(1),
  PhsrlAddress(2),
  PhsrlInvalid(3);

  final int value;
  const PH_SYMBOL_RESOLVE_LEVEL(this.value);

  factory PH_SYMBOL_RESOLVE_LEVEL.fromValue(int val) =>
      PH_SYMBOL_RESOLVE_LEVEL.values[val];
}

extension ToDartString on Pointer<PH_STRING> {
  String? toDartString() {
    if (this == nullptr) {
      return null;
    }
    final header = ref.unnamed;
    final strRef = header.sr;
    final len = strRef.Length;
    if (len <= 0) {
      return null;
    }
    return strRef.Buffer.cast<Utf16>().toDartString(
        // length: strRef.Length,
        );
  }
}
