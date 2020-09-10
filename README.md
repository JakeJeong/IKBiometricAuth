# IKBiometricAuth

Made it easy to use the biometric authentication function.

## Sample usage

```ObjC
    IKBiometricAuthResult * result;
    IKBiometricAuth.showAuthenticationWithResult(&result,BiometricAuthWithPasscode,@"response",@"fallbackTitle");
    if (result.resultType == AuthenticationSuccess) {
        // @"Success";
    } else {
        // [NSString stringWithFormat:@"[Failed] \n%@",result.message];
    }
```

## Author

JakeJeong - jikturbo@gmail.com

## License

IKBiometricAuth is available under the MIT license. See the LICENSE file for more info.
