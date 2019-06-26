Pod::Spec.new do |s|
  s.name             = 'PagerControl'
  s.version          = '1.1.0'
  s.summary          = 'Another PagerControl'
 
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
 
  s.homepage         = 'https://github.com/Atimca/PagerControl'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MaximSmirnov' => 'atimca@gmail.com' }
  s.source           = { :git => 'https://github.com/Atimca/PagerControl.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'Source/**/*'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
 
end