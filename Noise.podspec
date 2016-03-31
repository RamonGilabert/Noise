Pod::Spec.new do |s|
  s.name             = "Noise"
  s.summary          = "A short description of Noise."
  s.version          = "0.1.0"
  s.homepage         = "https://github.com/RamonGilabert/Noise"
  s.license          = 'MIT'
  s.author           = { "Ramon Gilabert" => "ramon@hyper.no" }
  s.source           = {
    :git => "https://github.com/RamonGilabert/Noise.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/RamonGilabert'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.requires_arc = true
  s.ios.source_files = 'Sources/{iOS,Shared}/**/*'
  s.osx.source_files = 'Sources/{Mac,Shared}/**/*'

  # s.ios.frameworks = 'UIKit', 'Foundation'
  # s.osx.frameworks = 'Cocoa', 'Foundation'

  # s.dependency 'Whisper', '~> 1.0'
end
