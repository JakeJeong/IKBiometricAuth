
Pod::Spec.new do |s|
    s.name             = "IKBiometricAuth"
    s.version          = "1.0.0"
    s.summary          = "BFKit is a collection of useful classes to develop Apps faster"
    s.homepage         = "https://github.com/JakeJeong/IKBiometricAuth"
    s.screenshots      = ""
    s.license          = {
                            :type => "MIT",
                            :file => "LICENSE"
                         }
    s.author           = { "Jake Jeong" => "jikturbo@gmail.com" }
    s.social_media_url = "facebook.com/inkyu.jeong.5"
    s.platform         = :ios, "8.0"
    s.source           = {
                            :git => "https://github.com/JakeJeong/IKBiometricAuth.git",
                            :tag => "v1.0.0"
                         }
    s.source_files     = "Source/**/*.{h,m}"
    s.resources        = "Source/Languages/**"
    s.weak_frameworks  = 'LocalAuthentication'
    s.requires_arc     = true
  end