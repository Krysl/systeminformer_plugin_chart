# TreeMap Plugin for [SystemInformer](https://github.com/winsiderss/systeminformer)

![Screenshot](https://github.com/user-attachments/assets/4b383a7f-aa3b-4204-824a-55a0e26a86af)

This repo is used to ~~help explain for~~ ***Solve*** the "[[Feature request] TreeMap View for Memory Usage](https://github.com/processhacker/processhacker/issues/1008)"

> An [early version](https://github.com/krysl/ProcessHacker_TreeMap) of the [web page implementation](https://krysl.github.io/ProcessHacker_TreeMap/) from 3 years ago, implemented using d3.js
> (The web version requires users to manually save the process tree information from SystemInformer as a `.csv` file and upload it to the web page for calculation and display, which is inconvenient to use.)

## Install
1. Download `plugins.zip` from [latest releases](https://github.com/Krysl/systeminformer_plugin_chart/releases/)
2. Unzip the files to the folder where systeminformer.exe is located.
3. Launch SystemInformer, set `EnableDefaultSafePlugins` in "Options"->"Advanced" to `0`
4. Restart SystemInformer
5. Click `View`->`chart` in the menu bar to launch the TreeMap view


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
