Pod::Spec.new do |s|
  s.name             = 'SearchablePicker'
  s.version          = '0.1.0'
  s.summary          = 'iOS picker view controller'
  s.homepage         = 'https://github.com/adamhongmy/SearchablePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<adamhongmy>' => '<adamhongmy@gmail.con>' }
  s.source           = { :git => 'https://github.com/adamhongmy/SearchablePicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'SearchablePicker/SearchablePicker/*'

end
