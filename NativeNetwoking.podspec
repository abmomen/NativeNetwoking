Pod::Spec.new do |s|
  s.name             = 'NativeNetwoking'
  s.version          = '1.1.0'
  s.summary          = 'A Library for native networking with url session'

  s.homepage         = 'https://github.com/abmomen/NativeNetwoking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'abmomen' => 'abdulmomen130@gmail.com' }
  s.source           = { :git => 'https://github.com/abmomen/NativeNetwoking.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'NativeNetwoking/Classes/**/*'
  
end
