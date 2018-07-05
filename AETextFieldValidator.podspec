Pod::Spec.new do |s|
  s.name             = "AETextFieldValidator"
  s.version          = "1.1.3"
  s.summary          = "A lightweight, customizable subclass of UITextField that supports multiple regex validations."
  s.homepage         = "https://github.com/canicelebrate/AETextFieldValidator"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "William Wang" => "canicelebrate@gmail.com" }
  s.source           = { :git => "https://github.com/canicelebrate/AETextFieldValidator.git", :tag => s.version }

  s.platform     = :ios, '10.0'
  s.requires_arc = true

s.source_files = 'AETextFieldValidator/*.{h,m}'
s.public_header_files = "AETextFieldValidator/AETextFieldValidator.h"
s.resources = "AETextFieldValidator/*.xcassets"
end
