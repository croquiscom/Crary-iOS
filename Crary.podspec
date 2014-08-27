#
# Be sure to run `pod lib lint Crary.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Crary'
  s.version          = '0.1.0'
  s.summary          = 'Croquis Library for iOS'
  s.homepage         = 'https://github.com/croquiscom/Crary-iOS'
  s.license          = 'MIT'
  s.author           = { 'yamigo' => 'yamigo1021@gmail.com' }
  s.source           = { :git => "https://github.com/croquiscom/Crary-iOS.git", :tag => '0.1.0' }
  s.requires_arc     = true

  s.platform         = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.resource_bundle = { 'Crary' => ['Pod/Assets/*.lproj'] }

  s.public_header_files = 'Pod/Classes/Crary.h', 'Pod/Classes/CraryDefine.h'
  s.source_files = 'Pod/Classes/Crary.{h,m}', 'Pod/Classes/Crary+Private.h', 'Pod/Classes/CraryDefine.h'
  s.prefix_header_contents = '#import <SystemConfiguration/SystemConfiguration.h>', '#import <MobileCoreServices/MobileCoreServices.h>'
  
  s.subspec 'RestClient' do |ss|
    ss.public_header_files = 'Pod/Classes/RestClient/CraryRestClient.h', 'Pod/Classes/RestClient/CraryRestClient+Gzip.h'
    ss.source_files = 'Pod/Classes/RestClient/CraryRestClient+Private.h', 'Pod/Classes/RestClient/CraryRestClient.{h,m}', 'Pod/Classes/RestClient/CraryRestClient+Gzip.{h,m}'
    ss.dependency 'AFNetworking', '~> 1.0'
    ss.ios.library = 'z'
  end
  
  s.subspec 'Util' do |ss|
    ss.public_header_files = 'UIAlertViewManager.h'
    ss.source_files = 'Pod/Classes/UIAlertViewManager.{h,m}'
  end
  
  s.subspec 'Category' do |ss|
    ss.public_header_files = 'UIAlertView+Crary.h'
    ss.source_files = 'Pod/Classes/UIAlertView+Crary.{h,m}'
  end
  
  s.subspec 'Dialog' do |ss|
    ss.public_header_files = 'CraryMessageBox.h'
    ss.source_files = 'Pod/Classes/Dialog/CraryMessageBox.{h,m}'
  end

end
