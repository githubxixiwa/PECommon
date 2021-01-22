Pod::Spec.new do |s|
  s.name             = 'PECommon'
  s.version          = '1.0.0'
  s.summary          = '最基础最少代码的工具包'

  s.description      = <<-DESC
  最基础最少代码的工具包
                       DESC

  s.homepage         = 'https://www.jianshu.com/u/50c12381f32c'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'caikun' => 'kunyu.cai@poleera.com' }
  s.source           = { :git => 'https://github.com/githubxixiwa/PECommon.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'PECommon/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PECommon' => ['PECommon/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
