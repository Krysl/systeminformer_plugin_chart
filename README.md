# TreeMap Plugin for [SystemInformer](https://github.com/winsiderss/systeminformer)

![Screenshot](https://github.com/user-attachments/assets/4b383a7f-aa3b-4204-824a-55a0e26a86af)

This repo is used to ~~help explain for~~ ***Solve*** the "[[Feature request] TreeMap View for Memory Usage](https://github.com/processhacker/processhacker/issues/1008)"

> An [early version](https://github.com/krysl/ProcessHacker_TreeMap) of the [web page implementation](https://krysl.github.io/ProcessHacker_TreeMap/) from 3 years ago, implemented using d3.js
> (The web version requires users to manually save the process tree information from SystemInformer as a `.csv` file and upload it to the web page for calculation and display, which is inconvenient to use.)

## Install
1. Download `plugins.zip` from [latest releases](https://github.com/Krysl/systeminformer_plugin_chart/releases/)

The plugin' version MUST match the SystemInformer' version (https://github.com/Krysl/systeminformer_plugin_chart/issues/3)

| Plugin version                                                                                      | SystemInformer version                                                                                                                                                                                                                                  |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [v1.0.0](https://github.com/Krysl/systeminformer_plugin_chart/releases/download/v1.0.0/plugins.zip) | ~~https://github.com/winsiderss/si-builds/releases/tag/3.2.25115.223~~  (not work)<br> https://github.com/winsiderss/si-builds/releases/tag/3.2.25116.2104 (Works) <br> ~https://github.com/winsiderss/si-builds/releases/tag/3.2.25121.437~ (Not work) |

2. Unzip the files to the plugins folder
```
│  SystemInformer.exe
│  ...
│
├─plugins
│  │  flutter_windows.dll
│  │  native_assets.yaml
│  │  systeminformer_plugin_chart.dll
│  │  ...
│  │
│  └─data
│      │  app.so
│      │  icudtl.dat
│      │
│      └─flutter_assets
│          │  AssetManifest.bin
│          │  AssetManifest.json
│          │  FontManifest.json
│          │  NativeAssetsManifest.json
│          │  NOTICES.Z
│          │
│          ├─fonts
│          │      MaterialIcons-Regular.otf
│          │
│          ├─packages
│          │  └─cupertino_icons
│          │      └─assets
│          │              CupertinoIcons.ttf
│          │
│          └─shaders
│                  ink_sparkle.frag
│
├─Resources
...
```
1. Launch SystemInformer, set `EnableDefaultSafePlugins` in "Options"->"Advanced" to `0`
   1. (if there is no "Advanced" tab:)
     -  in Tab "General"：
        - Check the last checkbox "Show advanced options"
2. Restart SystemInformer
3. Click `View`->`chart` in the menu bar to launch the TreeMap view


## TODOs (WIP)
- ✅ Done 
  - Can open CSV file saved by SystemInformer
  - refresh button to get current processes statictics
  - Support CPU/PrivateBytes/WorkSet for Treemap showing
  - show Icon for each process
  - Add statistics
  - add hideIdle switch
- 🛠️ Doing
  - Overlay/Hover Details
- ⏳ In progress
  - Add automatic refresh
  - Improve UI/UX for better usability
- 📅 Upcoming
  - scroll to Drilldown/ZoomOut
  - Add a button/shortcut to open the TreeMap chart
  - show cpu in every treemap tile
- 🚀 Future
  - DoubleClick to open the Property Dialog provided by SystemInformer
  - Add more categories
  - Optimize performance
  - More chart types
- 🗂️ Backlog
  - Implement multi-language support


## Develop
see [CONTRIBUTING.md](./CONTRIBUTING.md)
