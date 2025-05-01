
## Basic skills needed
- C/C++
- Dart/FLutter
- [D4](https://pub.dev/packages/d4)(The dart version of [d3.js](https://d3js.org/))
- [pigeons](https://pub.dev/packages/pigeon)
  - Pigeon is a code generator tool to make communication between Flutter and the host platform type-safe, easier, and faster.

## requirements
- Dart/FLutter
- VS2022
- git
- ...

## clone & build SystemInformer
1. `git clone git@github.com:winsiderss/systeminformer.git`
2. [Building the project](https://github.com/winsiderss/systeminformer?tab=readme-ov-file#building-the-project)
3. (for developers) 
   1. `git config --local include.path ../.gitconfig`



## setup Env
### using in building
- set `SYSTEMINFORMER_GIT_FOLDER` to the folder where you clone the SystemInformer git repository 

### config the SystemInformer
1. open `Options` (Menu "System"->"Options")
2. in Tab "General"：
   1. Check the last checkbox "Show advanced options"
3. in Tab "Advanced"：
   1. Type "chart" in the search box in the upper right corner (make sure "Hide default" is not checked in the drop-down menu that appears after clicking the Options button)
   2. set `ProcessHacker.ProcessChart.VSCode.launch.json`'s Value to path/to/.vscode/launch.json
      1. `Future<void> patchLaunchJson(Uri url)` in [lib/src/utils/debug.dart:47](lib/src/utils/debug.dart#L47) will patch the vmServiceUri in `.vscode/launch.json`


## some usefull script is in [./justfile](./justfile)
it's a script run by a simple command runner called [`just`](https://just.systems/) ([manual for `just`](https://just.systems/man/en/))

## Do after Updated SystemInformer SDK!

### update `lib\src\system_informer\generated_bindings.dart`
1. run `dart run ffigen --config ffigen.yaml` to generate `lib\src\system_informer\generated_bindings.dart`
2. fix 
    - replace `sealed class VERIFYRESULT {}` in `generated_bindings.dart` with  `typedef VERIFYRESULT = data_type.VERI`
    - replace `sealed class PH_SYMBOL_RESOLVE_LEVEL {}` in `generated_bindings.dart` with `typedef PH_SYMBOL_RESOLVE_LEVEL = data_type`


## Debug

