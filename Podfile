platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'CSBootcamp' do
  
  pod 'Kingfisher'
  pod 'Moya'
  pod 'SwiftLint'
  pod 'Firebase/Analytics'

  target 'CSBootcampTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'OHHTTPStubs/Swift'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end