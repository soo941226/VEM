Pod::Spec.new do |project|
  project.name             = 'VEM'
  project.version          = '0.1.3'
  project.summary          = 'Visual effects manager'
  project.swift_versions   = '5.5'
  project.homepage         = 'https://github.com/soo941226/VEM'
  project.license          = { :type => 'MIT', :file => 'LICENSE' }
  project.author           = { 'soo941226' => '83933153+soo941226@users.noreply.github.com' }
  project.source           = { :git => 'https://github.com/soo941226/VEM.git', :tag => project.version.to_s }
  project.ios.deployment_target = '13.0'
  project.source_files = 'Core/**/*'
end
