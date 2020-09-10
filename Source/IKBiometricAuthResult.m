//
//  IKBiometricAuthResult.m
//  IKBiometricAuthAuth
//
//  Created by ikjeong on 2020/09/10.
//  Copyright © 2020 ikjeong. All rights reserved.
//

#import "IKBiometricAuthResult.h"

@implementation IKBiometricAuthResult
+ (IKBiometricAuthResult * _Nonnull (^)(NSError*))result {
    return ^(NSError *error) {
        IKBiometricAuthResult * osStatus = [[IKBiometricAuthResult alloc]initWithError:error];
        return osStatus;
    };
}
+ (IKBiometricAuthResult * _Nonnull (^)(void))resultSuccess {
    return ^(void) {
        IKBiometricAuthResult * osStatus = [[IKBiometricAuthResult alloc]initWithSuccess];
        return osStatus;
    };
}
- (instancetype)initWithError:(NSError*)error {
    self = [super init];
    if (self) {
        [self updateCode:error.code];
    }
    return self;
}
- (instancetype)initWithSuccess {
    self = [super init];
    if (self) {
        [self updateCode:AuthenticationSuccess];
    }
    return self;
}
- (void)updateCode:(NSInteger)code {
    _resultType = code;
}
- (NSString*)message {
    return [self convertError:self.resultType];
}
- (NSString*)convertError:(NSInteger)code {
    NSString * errorMessage = @"";
    switch (code) {
        case LAErrorAuthenticationFailed:
            errorMessage = @"Authentication was not successful, because user failed to provide valid credentials.";
            break;
        case LAErrorUserCancel:
            errorMessage = @"Authentication was canceled by user (e.g. tapped Cancel button).";
            break;
        case LAErrorUserFallback:
            errorMessage = @"Authentication was canceled, because the user tapped the fallback button (Enter Password).";
            break;
        case LAErrorSystemCancel:
            errorMessage = @"Authentication was canceled by system (e.g. another application went to foreground).";
            break;
        case LAErrorPasscodeNotSet:
            errorMessage = @"Authentication could not start, because passcode is not set on the device.";
            break;
        case LAErrorAppCancel:
            errorMessage = @"Authentication was canceled by application (e.g. invalidate was called while authentication was in progress).";
            break;
        case LAErrorInvalidContext:
            errorMessage = @"LAContext passed to this call has been previously invalidated.";
            break;
        case LAErrorBiometryNotAvailable:
            errorMessage = @"LAContext passed to this call has been previously invalidated.";
            break;
        case LAErrorBiometryNotEnrolled:
            errorMessage = @"Authentication could not start, because biometry has no enrolled identities.";
            break;
        case LAErrorBiometryLockout:
            errorMessage = @"Authentication was not successful, because there were too many failed biometry attempts an";
            break;
        case LAErrorNotInteractive:
            errorMessage = @"Authentication failed, because it would require showing UI which has been forbidden";
            break;
        default:
            break;
    }
    return errorMessage;
}
- (void)dealloc {
    NSLog(@"IKBiometricAuthResult dealloc : %p",self);
    
}
/*
 - (NSString*)convertMessage:(OSStatus)status {
     NSString * resultMessage = @"";
     switch (status) {
         case errSecNotAvailable:
             resultMessage = @"No trust results are available.";
             break;
         case errSecReadOnly:
             resultMessage = @"Read-only error.";
             break;
         case errSecAuthFailed:
             resultMessage = @"Authorization and/or authentication failed.";
             break;
         case errSecNoSuchKeychain:
             resultMessage = @"The keychain does not exist.";
             break;
         case errSecInvalidKeychain:
             resultMessage = @"The keychain is not valid.";
             break;
         case errSecDuplicateKeychain:
             resultMessage = @"A keychain with the same name already exists.";
             break;
         case errSecDuplicateCallback:
             resultMessage = @"More than one callback of the same name exists.";
             break;
         case errSecInvalidCallback:
             resultMessage = @"The callback is not valid.";
             break;
         case errSecDuplicateItem:
             resultMessage = @"The item already exists.";
             break;
         case errSecItemNotFound:
             resultMessage = @"The item cannot be found.";
             break;
         case errSecBufferTooSmall:
             resultMessage = @"The buffer is too small.";
             break;
         case errSecDataTooLarge:
             resultMessage = @"The data is too large for the particular data type.";
             break;
         case errSecNoSuchAttr:
             resultMessage = @"The attribute does not exist.";
             break;
         case errSecInvalidItemRef:
             resultMessage = @"The item reference is invalid.";
             break;
         case errSecNoSuchClass:
             resultMessage = @"The keychain item class does not exist.";
             break;
         case errSecNoDefaultKeychain:
             resultMessage = @"A default keychain does not exist.";
             break;
         case errSecInteractionNotAllowed:
             resultMessage = @"Interaction with the Security Server is not allowed.";
             break;
         case errSecReadOnlyAttr:
             resultMessage = @"The attribute is read-only.";
             break;
         case errSecWrongSecVersion:
             resultMessage = @"The version is incorrect.";
             break;
         case errSecKeySizeNotAllowed:
             resultMessage = @"The key size is not allowed.";
             break;
         case errSecNoStorageModule:
             resultMessage = @"There is no storage module available.";
             break;
         case errSecNoCertificateModule:
             resultMessage = @"There is no storage module available.";
             break;
         case errSecNoPolicyModule:
             resultMessage = @"There is no policy module available.";
             break;
         case errSecInteractionRequired:
             resultMessage = @"User interaction is required.";
             break;
         case errSecDataNotAvailable:
             resultMessage = @"The data is not available.";
             break;
         case errSecDataNotModifiable:
             resultMessage = @"The data is not modifiable.";
             break;
         case errSecCreateChainFailed:
             resultMessage = @"The attempt to create a certificate chain failed.";
             break;
         case errSecInvalidPrefsDomain:
             resultMessage = @"The preference domain specified is invalid.";
             break;
         case errSecInDarkWake:
             resultMessage = @"The user interface cannot be displayed because the system is in a dark wake state.";
             break;
             
         default:
             break;
     }
     return resultMessage;
 }
 /// Authentication was not successful, because user failed to provide valid credentials.
    kLAErrorAuthenticationFailed,
    
    /// Authentication was canceled by user (e.g. tapped Cancel button).
    kLAErrorUserCancel,
    
    /// Authentication was canceled, because the user tapped the fallback button (Enter Password).
    kLAErrorUserFallback,
    
    /// Authentication was canceled by system (e.g. another application went to foreground).
    kLAErrorSystemCancel,
    
    /// Authentication could not start, because passcode is not set on the device.
    kLAErrorPasscodeNotSet,

    /// Authentication could not start, because Touch ID is not available on the device.
    kLAErrorTouchIDNotAvailable,

    /// Authentication could not start, because Touch ID has no enrolled fingers.
    kLAErrorTouchIDNotEnrolled,

    /// Authentication was not successful, because there were too many failed Touch ID attempts and
    /// Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating
    /// LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
    kLAErrorTouchIDLockout,

    /// Authentication was canceled by application (e.g. invalidate was called while
    /// authentication was in progress).
    kLAErrorAppCancel,

    /// LAContext passed to this call has been previously invalidated.
    kLAErrorInvalidContext,

    /// Authentication could not start, because biometry is not available on the device.
    kLAErrorBiometryNotAvailable,

    /// Authentication could not start, because biometry has no enrolled identities.
    kLAErrorBiometryNotEnrolled,

    /// Authentication was not successful, because there were too many failed biometry attempts and
    /// biometry is now locked. Passcode is required to unlock biometry, e.g. evaluating
    /// LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
    kLAErrorBiometryLockout,
    
    /// Authentication failed, because it would require showing UI which has been forbidden
    /// by using interactionNotAllowed property.
    kLAErrorNotInteractive,
    
    /// Authentication could not start, because there was no paired watch device nearby.
    kLAErrorWatchNotAvailable,
 */
@end
