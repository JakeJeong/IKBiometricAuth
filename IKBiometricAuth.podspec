
Pod::Spec.new do |s|
    s.name             = "IKBiometricAuth"
    s.version          = "1.0.1"
    s.summary          = "We made it easy to use the biometric authentication function."
    s.homepage         = "https://github.com/JakeJeong/IKBiometricAuth"
    s.screenshots      = ""
    s.license          = {
                            :type => "MIT",
                            :file => "LICENSE"
                         }
    s.author           = { "Jake Jeong" => "jikturbo@gmail.com" }
    s.social_media_url = "https://facebook.com/inkyu.jeong.5"
    s.platform         = :ios, "9.0"
    s.source           = {
                            :git => "https://github.com/JakeJeong/IKBiometricAuth.git",
                            :tag => "v1.0.1"
                         }
    s.source_files     = "Source/*.{h,m}"
    s.weak_frameworks  = 'LocalAuthentication'
    s.requires_arc     = true
  end