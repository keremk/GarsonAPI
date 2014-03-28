#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "GarsonAPI"
  s.version          = "0.1.0"
  s.summary          = "Data layer access API to users, restaurant menus, ordering."
  s.description      = <<-DESC
                       An optional longer description of GarsonAPI

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://codingventures.com"
  s.license          = 'MIT'
  s.author           = { "Kerem Karatal" => "kkaratal@yahoo.com" }
  s.source           = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/keremk'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Resources'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'SystemConfiguration'
  s.dependency 'AFNetworking', '~> 2.2'
  s.dependency 'SSKeychain', '~> 1.2'
  s.dependency 'Facebook-iOS-SDK', '~> 3.12'
  s.dependency 'ReactiveCocoa', '~> 2.2'
  s.dependency 'Mantle', '~> 1.3'
end
