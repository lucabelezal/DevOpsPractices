platform :ios, '12.0'
inhibit_all_warnings!

install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'CsBootcamp' do
  use_frameworks!

  pod 'Kingfisher'
  pod 'Moya'
  pod 'SwiftLint'

  target 'CsBootcampTests' do
      inherit! :search_paths
      pod 'Quick'
      pod 'Nimble'
      pod 'OHHTTPStubs/Swift'
  end
end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end