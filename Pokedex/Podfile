source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

workspace ‘Pokedex.xcworkspace'

def all_pods
  pod 'Alamofire', '~> 4.0'
  pod 'Timberjack', :git => 'https://github.com/gilthonweapps/Timberjack'
  pod 'SwiftyJSON'
end

target ‘Pokedex’ do
    all_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
