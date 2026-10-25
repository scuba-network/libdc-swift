# libdc-swift as shipped in DSCNT

This fork publishes the exact copy of libdc-swift that the DSCNT iPhone app
ships, as the LGPL 2.1 asks. Each DSCNT copy is a tag named
`<upstream release>-dscnt.<n>`, made from that upstream release. This one,
`1.18.0-dscnt.1`, is upstream [1.18.0](https://github.com/deepsealabs/libdc-swift/releases/tag/1.18.0)
plus the changes below.

## What is changed

Only `Sources/LibDCSwift/`. Nothing else in the upstream tree is changed.

1. **One behaviour change, in `BLEManager.swift`.** Upstream always creates its
   Bluetooth manager with a state restoration identifier. iOS throws
   `NSInternalInconsistencyException`, and ends the app, when an app that does
   not declare the `bluetooth-central` background mode does that. DSCNT does
   not declare it, so the manager asks for state restoration only when the
   app's `UIBackgroundModes` includes `bluetooth-central`. Marked
   "DSCNT change" in the file. (The comment there points at `VENDORED.md`,
   DSCNT's private notes about this copy; this file says the same.)
2. **Import lines, in 12 files.** DSCNT builds libdc-swift with CocoaPods
   instead of Swift Package Manager. One pod, `LibDCBridge`, replaces the
   package's `Clibdivecomputer` and `LibDCBridge` targets, so
   `import Clibdivecomputer` and `import LibDCBridge.CoreBluetoothManagerProtocol`
   became `import LibDCBridge`. Some files now import it twice, which Swift
   accepts.

Because of the import lines, this tag does not build with `Package.swift`. It
builds with the two podspecs in `dscnt/`, which are DSCNT's, unchanged. Their
paths are the layout of DSCNT's own vendor folder:

- `LibDCSwift.podspec`: upstream `Sources/LibDCSwift/`, as changed here,
  without `include/module.modulemap`.
- `LibDCBridge.podspec`: upstream `Sources/LibDCBridge/` (unchanged), together
  with [libdivecomputer](https://github.com/deepsealabs/libdivecomputer) at
  `1f7c4ff1cab0368a1ee1a6edbd61e30667d339c0` (unchanged), the commit 1.18.0
  pins. libdivecomputer's `version.h` is generated from its `version.h.in`, as
  upstream's build plugin does, for version `0.10.0-devel`.

Both are built as separate dynamic frameworks, so either can be replaced with
a modified copy and the app relinked.

## Offered upstream

DSCNT plans to offer the behaviour change to deepsealabs/libdc-swift. When an upstream
release includes it, the next DSCNT copy will differ by the import lines only.
