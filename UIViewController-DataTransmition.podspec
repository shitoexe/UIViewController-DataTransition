#
#  Be sure to run `pod spec lint UIViewController-DataTransmition.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "UIViewController-DataTransmition"
  s.version      = "1.0"
  s.summary      = "Extension of UIViewController for passing data between VC during navigation transition"
  s.license      = "MIT"
  s.homepage     = "https://github.com/shitoexe/UIViewController-DataTransfer"
  s.author             = { "Alexey Shadura" => "shito.work@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/shitoexe/UIViewController-DataTransfer.git", :tag => "#{s.version}" }
  s.source_files  = "Extension", "Extension/**/*.swift"

end
