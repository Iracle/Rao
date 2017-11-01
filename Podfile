# Uncomment this line to define a global platform for your project
# platform :ios, ’9.0’
# Uncomment this line if you're using Swift
use_frameworks!

target 'Rao' do

#pod 'SnapKit', '~> 3.0.2'
#pod 'RealmSwift’, ‘~> 2.0.3’

pod 'SnapKit', '~> 4.0.0'
pod 'RealmSwift’, ‘~> 3.0.1’

end

target 'RaoTests' do

end

target 'RaoUITests' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0' # or '3.2'
    end
  end
end

