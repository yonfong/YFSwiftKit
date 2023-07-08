#
# Be sure to run `pod lib lint YFSwiftKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YFSwiftKit'
  s.version          = '0.5.0'
  s.summary          = 'YFSwiftKit: a collection of useful swift extension'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  YFSwiftKit: a collection of useful swift extension.
                       DESC

  s.homepage         = 'https://github.com/yonfong/YFSwiftKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yonfong' => 'yongfongzhang@163.com' }
  s.source           = { :git => 'https://github.com/yonfong/YFSwiftKit.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.default_subspec = 'SwiftKit'
  
  # YFSwiftKit
  s.subspec 'SwiftKit' do |swiftKit|
    swiftKit.source_files = 'YFSwiftKit/Classes/**/*'
  end
  
  # Define
  s.subspec 'Define' do |define|
    define.source_files = 'YFSwiftKit/Classes/Define/**/*'
  end
  
  #UIKit
  s.subspec 'UIKit' do |uikit|
      uikit.source_files = 'YFSwiftKit/Classes/UIKit/**/*'
      
      uikit.subspec 'Color' do |color|
        color.source_files = 'YFSwiftKit/Classes/UIKit/Color/**/*'
      end
      uikit.subspec 'CollectionView' do |collectionView|
        collectionView.source_files = 'YFSwiftKit/Classes/UIKit/CollectionView/**/*'
      end
      uikit.subspec 'TableView' do |tableView|
        tableView.source_files = 'YFSwiftKit/Classes/UIKit/TableView/**/*'
      end
  end
  
end
