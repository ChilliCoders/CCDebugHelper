Pod::Spec.new do |s|
  s.name             = "CCDebugHelper"
  s.version          = "1.0.2"
  s.summary          = "Library for fast debug view controllers in large applications"
  
  s.homepage         = "http://chillicoders.com"
  s.license          = 'MIT'
  s.author           = { "Rafał Wójcik" => "rafalwojcik@me.com" }
  s.source           = { :git => "https://github.com/ChilliCoders/CCDebugHelper.git", :tag => "1.0.2", :submoddules => true }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true   
  s.framework = "UIKit"
  s.source_files = "CCDebugHelper/**/*.{h,m}"
  s.header_dir = 'CCDebugHelper'
  s.public_header_files = 'CCDebugHelper/**/*.h'
  s.ios.resource_bundle = { 'CCDebugHelperBundle' => 'CCDebugHelper/Resources/**/*.{xib,png,jpg,jpeg}' }

end
