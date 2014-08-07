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

  s.public_header_files = 'Pod/Classes/CraryDefine.h', 'Pod/Classes/Crary.h'
  s.source_files = 'Pod/Classes/CraryDefine.h', 'Pod/Classes/Crary.h'
  
  s.subspec 'RestClient' do |ss|
    ss.public_header_files = 'Pod/Classes/CraryRestClient.h'
    ss.source_files = 'Pod/Classes/AFGzipClient.{h,m}', 'Pod/Classes/NSData+Compression.{h,m}', 'Pod/Classes/CraryRestClient.{h,m}'
    ss.dependency 'AFNetworking', '~> 1.0'
    ss.dependency 'ReactiveCocoa', '~> 2.3'
    ss.ios.library = 'z'
  end
  
  s.subspec 'UIViewExtension' do |ss|
    ss.public_header_files = 'UIAlertViewWithButton.h'
    ss.source_files = 'Pod/Classes/UIAlertViewWithButton.{h,m}'
  end
end
