platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

target 'WeatherApp' do
    pod 'RestKit'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = "NO"
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
