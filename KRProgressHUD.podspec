Pod::Spec.new do |s|
  s.name         = "KRProgressHUD"
  s.version      = "3.4.7"
  s.summary      = "A beautiful progress HUD for your iOS."
  s.description  = "KRProgressHUD is a beautiful and easy-to-use HUD meant to display the progress on iOS."
  s.homepage     = "https://github.com/krimpedance/KRProgressHUD"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "krimpedance" => "info@krimpedance.com" }
  s.requires_arc = true
  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.3'

  s.source       = { :git => "https://github.com/krimpedance/KRProgressHUD.git", :tag => s.version.to_s }
  s.source_files = "KRProgressHUD/**/*.swift"

  s.dependency "KRActivityIndicatorView", "3.0.7"

  spec.subspec 'App' do |app|
  end

  spec.subspec 'AppExtension' do |ext|
    # For app extensions, disabling code paths using unavailable API
    ext.pod_target_xcconfig = {
      'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'APP_EXTENSION',
      'GCC_PREPROCESSOR_DEFINITIONS' => 'APP_EXTENSION=1'
    }
  end

end
