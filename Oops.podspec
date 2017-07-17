Pod::Spec.new do |s|
  s.name             = "Oops"
  s.version          = "1.0.1"
  s.summary          = "A delightful dialog view for iOS written in Swift"
  s.description      = <<-DESC
                        Oops is a delightful dialog view for iOS written in Swift.
                        DESC

  s.homepage         = "https://github.com/Meniny/Oops"
  s.license          = 'MIT'
  s.author           = { "Meniny" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/Oops.git", :tag => s.version.to_s }
  s.social_media_url = 'https://meniny.cn/'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Oops/*.*'
  s.public_header_files = 'Oops/Oops.h'
  s.frameworks = 'Foundation', 'UIKit'
end
