# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iVM360' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'IQKeyboardManagerSwift'
  pod 'AlamofireImage'
  pod 'Kingfisher'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'DropDown'
  pod 'Cosmos'
  pod "SwiftSignatureView"
  pod 'FSCalendar'
  pod 'Cosmos'
  # Firebase Messaging
  pod 'Firebase/Messaging'
#  pod 'DropDown'
#  pod 'SideMenu'
#  pod 'SwiftyJSON'
  # Pods for iVM360

end
# Ensure deployment target compatibility
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#      config.build_settings['TOOLCHAIN_DIR'] = '$(TOOLCHAIN_DIR)'
#    end
#  end
#end
