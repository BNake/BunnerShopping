# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
# Uncomment this line if you're using Swift
use_frameworks!
inhibit_all_warnings!

def shared_pods
    pod 'Alamofire', '4.7.3'
    pod 'CocoaLumberjack/Swift', '3.4.2'
    pod 'SnapKit', '4.0.1'
    pod 'Kingfisher', '4.10.0'
    pod 'KeychainAccess', '3.1.2'
    pod 'IQKeyboardManagerSwift', '6.2.0'
    pod 'Firebase/Core', '5.13.0'
    pod 'Firebase/Messaging', '5.13.0'
    pod 'INTULocationManager', '4.3.2'
    pod 'SwiftLint', '0.29.0'
    pod 'RealmSwift', '3.12.0'
    pod 'PromiseKit/CorePromise', '6.5.1'
    pod 'PromiseKit/Alamofire', '6.5.1'
    pod 'SkyFloatingLabelTextField', '~> 3.0'
    pod 'XLPagerTabStrip', '~> 8.1'

end

target 'VIPTemplate' do
    shared_pods
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
                config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
                config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            end
        end
    end
end

target 'VIPTemplateTests' do
    shared_pods
end
