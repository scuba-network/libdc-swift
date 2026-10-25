# The Swift half of libdc-swift: the CoreBluetooth manager, device
# identification and dive retrieval, vendored for DSCNT (#548, ADR 27).
# LGPL-2.1, built as its own dynamic framework so it can be relinked.
# What was changed is in ../VENDORED.md.
Pod::Spec.new do |s|
  s.name          = 'LibDCSwift'
  s.version       = '1.18.0'
  s.summary       = 'libdc-swift, as DSCNT ships it.'
  s.homepage      = 'https://github.com/deepsealabs/libdc-swift'
  s.license       = { :type => 'LGPL-2.1', :file => 'LICENSE' }
  s.authors       = { 'libdc-swift contributors' => 'https://github.com/deepsealabs/libdc-swift' }
  s.source        = { :git => 'https://github.com/deepsealabs/libdc-swift.git', :tag => '1.18.0' }
  s.platforms     = { :ios => '16.4' }
  # Written for Swift 5 language mode, as its Package.swift builds it.
  s.swift_version = '5.0'

  s.source_files  = '**/*.swift'
  s.frameworks    = 'CoreBluetooth', 'Foundation', 'Combine', 'SwiftUI', 'UIKit'
  s.dependency 'LibDCBridge'
  # See LibDCBridge.podspec: how libdivecomputer's headers find each other.
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '"${PODS_CONFIGURATION_BUILD_DIR}/LibDCBridge/LibDCBridge.framework/Headers"',
  }
end
