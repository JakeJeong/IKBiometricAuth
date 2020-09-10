# IKBiometricAuth

Made it easy to use the biometric authentication function.

## Sample usage

```ObjC
    // case 1
    IKBiometricAuthResult * result;
    IKBiometricAuth.showAuthenticationWithResult(&result,BiometricAuthWithPasscode,@"reason",@"fallbackTitle");
    if (result.resultType == AuthenticationSuccess) {
        // @"Success";
    } else {
        // [NSString stringWithFormat:@"[Failed] \n%@",result.message];
    }

    // case 2
    IKBiometricAuthResult * result = IKBiometricAuth.showAuthentication(BiometricAuthWithPasscode, @"reason", @"fallbackTitle");
    if (result.resultType == AuthenticationSuccess) {
        // @"Success";
    } else {
        // [NSString stringWithFormat:@"[Failed] \n%@",result.message];
    }

    // case 3
     IKBiometricAuth.showAuthenticationWithResultBlock(BiometricAuthWithPasscode,self.reason, self.fallbackTitle, ^(IKBiometricAuthResult * _Nonnull result) {
        if (result.resultType == AuthenticationSuccess) {
            // @"Success";
        } else {
           // [NSString stringWithFormat:@"[Failed] \n%@",result.message];
        }
    });
```

## Info.plist 

```ObjC
 //Set 'NSFaceIDUsageDescription' in the Info.plist.
 NSFaceIDUsageDescription
```

#### CocoaPods
- ```pod 'IKBiometricAuth'```
- Import the Framework with ```import IKBiometricAuth```

## Author

JakeJeong - jikturbo@gmail.com

## License

IKBiometricAuth is available under the MIT license. See the LICENSE file for more info.
