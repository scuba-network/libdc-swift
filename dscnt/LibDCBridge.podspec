# libdivecomputer, and the C and Objective-C Bluetooth bridge from
# libdc-swift, vendored for DSCNT (#548, ADR 27). Both are LGPL-2.1.
#
# Built as its own dynamic framework (see plugins/with-dive-computer.js), so
# that a diver can relink the app against a modified copy, as the LGPL asks.
# What was taken from where, and what was changed, is in ../VENDORED.md.
Pod::Spec.new do |s|
  s.name         = 'LibDCBridge'
  s.version      = '1.18.0'
  s.summary      = 'libdivecomputer and the libdc-swift Bluetooth bridge, as DSCNT ships them.'
  s.homepage     = 'https://github.com/deepsealabs/libdc-swift'
  s.license      = { :type => 'LGPL-2.1', :file => 'COPYING' }
  s.authors      = { 'libdivecomputer and libdc-swift contributors' => 'https://github.com/deepsealabs/libdc-swift' }
  s.source       = { :git => 'https://github.com/deepsealabs/libdc-swift.git', :tag => '1.18.0' }
  s.platforms    = { :ios => '16.4' }

  s.source_files        = 'include/**/*.h', 'src/**/*.{c,h}', 'bridge/*.{c,m}'
  s.exclude_files       = 'src/serial_win32.c'
  s.public_header_files = 'include/**/*.h'
  # Keeps libdivecomputer's headers under libdivecomputer/, which is how the
  # bridge and the library itself include them.
  s.header_mappings_dir = 'include'
  s.frameworks          = 'CoreBluetooth', 'Foundation'

  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '"$(PODS_TARGET_SRCROOT)/include" "$(PODS_TARGET_SRCROOT)/include/libdivecomputer" "$(PODS_TARGET_SRCROOT)/src"',
    # As libdc-swift's Package.swift builds it: pthreads, and logging on, so
    # a protocol error says which check failed instead of a bare status.
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) HAVE_PTHREAD_H=1 ENABLE_LOGGING=1 OBJC_OLD_DISPATCH_PROTOTYPES=1',
    'GCC_WARN_INHIBIT_ALL_WARNINGS' => 'YES',
    'DEFINES_MODULE' => 'YES',
  }
  # libdivecomputer's headers include each other as "libdivecomputer/x.h",
  # which resolves only from the framework's Headers folder. Anything that
  # imports this module needs that folder searched: the app target here, and
  # the pods that import it in their own podspecs.
  s.user_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '"${PODS_CONFIGURATION_BUILD_DIR}/LibDCBridge/LibDCBridge.framework/Headers"',
  }
end
