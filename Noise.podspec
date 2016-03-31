Pod::Spec.new do |s|
  s.name             = "Noise"
  s.summary          = "I frequently hear music in the very heart of noise."
  s.version          = "0.1.0"
  s.homepage         = "https://github.com/RamonGilabert/Noise"
  s.license          = 'MIT'
  s.author           = { "Ramon Gilabert" => "ramon.gilabert.llop@gmail.com" }
  s.source           = {
    :git => "https://github.com/RamonGilabert/Noise.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/RamonGilabert'

  s.ios.deployment_target = '8.0'

  s.requires_arc = true
  s.ios.source_files = 'Sources/*'
  s.osx.source_files = 'Sources/*'
end
