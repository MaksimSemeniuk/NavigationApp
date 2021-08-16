# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'NavigationApp' do
  use_frameworks!
  pod 'GoogleMaps'
  pod 'SideMenu', '~> 6.0'
  pod 'Firebase/Auth'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
     end
  end
end

