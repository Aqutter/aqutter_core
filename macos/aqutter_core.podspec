#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint aqutter_core.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'aqutter_core'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'aqutter_core/Sources/aqutter_core/**/*.swift'
  s.dependency 'FlutterMacOS'
  s.resource_bundles = {'aqutter_core_privacy' => ['aqutter_core/Sources/aqutter_core/Resources/PrivacyInfo.xcprivacy']}

  # swift-collections podspec doesn't declare macOS support, so we must use OrderedSet library
  # s.dependency 'swift-collections', '~>1.1.1'
  s.dependency 'OrderedSet', '~>6.0.3'

  s.platform = :osx, '12.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.xcconfig = {
    'LIBRARY_SEARCH_PATHS' => '$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)/ $(SDKROOT)/usr/lib/swift',
    'LD_RUNPATH_SEARCH_PATHS' => '/usr/lib/swift',
  }
  s.swift_version = '5.0'
end
