//
//  IKBiometricAuth.m
//  IKBiometricAuth
//
//  Created by ikjeong on 2020/09/10.
//  Copyright © 2020 ikjeong. All rights reserved.
//

#import "IKBiometricAuth.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation IKBiometricAuth

+ (IKBiometricAuthResult * _Nonnull (^)(BiometricAuthType,NSString * _Nonnull, NSString * _Nullable))showAuthentication {
    return ^(BiometricAuthType authType,NSString * reason,NSString * fallbackTitle){
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        LAContext *context = [[LAContext alloc] init];
        context.localizedFallbackTitle = fallbackTitle == nil ? @"" : fallbackTitle;
        __block IKBiometricAuthResult * biometricResult;
        NSError *error = nil;
        void(^replyAuth)(BOOL,NSError*) = ^(BOOL success,NSError* error) {
            if (success) {
                biometricResult = IKBiometricAuthResult.resultSuccess();
            } else {
                if (error.code == kLAErrorBiometryLockout || error.code == kLAErrorUserFallback || error.code == kLAErrorUserFallback) {
                    biometricResult = IKBiometricAuth.showAuthentication(BiometricAuthWithPasscode,reason,fallbackTitle);
                }
                else {
                    biometricResult = IKBiometricAuthResult.result(error);
                }
            }
            dispatch_semaphore_signal(semaphore);
        };
        if ([context canEvaluatePolicy:[[self class] biometricToLAPolicy:authType] error:&error]) {
            [context evaluatePolicy:[[self class] biometricToLAPolicy:authType] localizedReason:reason reply:replyAuth];
        } else {
            replyAuth(false,error);
        }
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        return biometricResult;
    };
}
+ (void (^)(IKBiometricAuthResult * _Nullable __strong * _Nullable,BiometricAuthType, NSString * _Nullable, NSString * _Nullable))showAuthenticationWithResult {
    return ^(IKBiometricAuthResult * _Nullable __strong * _Nullable result,BiometricAuthType authType,NSString * _Nullable reason,NSString * _Nullable fallbackTitle) {
        LAContext *context = [[LAContext alloc] init];
        context.localizedFallbackTitle = fallbackTitle == nil ? @"" : fallbackTitle;
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        __block NSError *error = nil;
        void(^replyAuth)(BOOL,NSError*) = ^(BOOL success,NSError* error) {
            if (success) {
                *result = IKBiometricAuthResult.resultSuccess();
            } else {
                if (error.code == kLAErrorSystemCancel || error.code == kLAErrorBiometryLockout || error.code == kLAErrorUserFallback) {
                    *result = IKBiometricAuth.showAuthentication(BiometricAuthWithPasscode,reason,fallbackTitle);
                } else {
                    *result = IKBiometricAuthResult.result(error);
                }
            }
            dispatch_semaphore_signal(semaphore);
        };
        if ([context canEvaluatePolicy:[[self class] biometricToLAPolicy:authType] error:&error]) {
            [context evaluatePolicy:[[self class] biometricToLAPolicy:authType] localizedReason:reason reply:replyAuth];
        } else {
            replyAuth(false,error);
        }
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
}
+ (void (^)(BiometricAuthType,NSString * _Nullable, NSString * _Nullable, ResultBlock _Nonnull))showAuthenticationWithResultBlock {
    return ^(BiometricAuthType authType, NSString * _Nullable reason,NSString * _Nullable fallbackTitle,ResultBlock resultblock) {
        LAContext *context = [[LAContext alloc] init];
        context.localizedFallbackTitle = fallbackTitle == nil ? @"" : fallbackTitle;
        __block NSError *error = nil;
        void(^replyAuth)(BOOL,NSError*) = ^(BOOL success,NSError* error) {
            if (error.code == kLAErrorBiometryLockout || error.code == kLAErrorUserFallback) {
                IKBiometricAuth.showAuthenticationWithResultBlock(BiometricAuthWithPasscode, reason, fallbackTitle, resultblock);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        resultblock(IKBiometricAuthResult.resultSuccess());
                    } else {
                        resultblock(IKBiometricAuthResult.result(error));
                    }
                });
            }
        };
        if ([context canEvaluatePolicy:[[self class] biometricToLAPolicy:authType] error:&error]) {
            [context evaluatePolicy:[[self class] biometricToLAPolicy:authType] localizedReason:reason reply:replyAuth];
        } else {
            replyAuth(false,error);
        }
    };
}
+ (LAPolicy)biometricToLAPolicy:(BiometricAuthType)type {
    if (type == BiometricAuthOnly) {
        return LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    }
    return LAPolicyDeviceOwnerAuthentication;
}
+ (BiometricType (^)(void))BiometricType {
    return ^(void) {
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        }
        if (error != nil) {
            return BiometricTypeUnknown;
        }
        
        if (@available(iOS 11.0, *)) {
            return [[self class] convertBitometricType:context.biometryType];
        } else {
            return BiometricTypeUnknown;
        }
    };
}
void IKBiometricAuthAuthentication(IKBiometricAuthResult * _Nullable __strong*_Nullable result,BiometricAuthType authType,NSString*_Nullable reason,NSString*_Nullable fallbackTitle) {
    return IKBiometricAuth.showAuthenticationWithResult(result,authType,reason,fallbackTitle);
}
IKBiometricAuthResult* IKBiometricAuthShowAuthentication(BiometricAuthType authType,NSString*reason,NSString*fallbackTitle) {
    return IKBiometricAuth.showAuthentication(authType,reason,fallbackTitle);
}
+ (BiometricType)convertBitometricType:(LABiometryType)type  API_AVAILABLE(ios(11.0)){
    BiometricType returnType = BiometricTypeNone;
    switch (type) {
        case LABiometryTypeNone:
            returnType = BiometricTypeNone;
            break;
        case LABiometryTypeTouchID:
            returnType = BiometricTypeTouchID;
            break;
        case LABiometryTypeFaceID:
            returnType = BiometricTypeFaceID;
            break;
        default:
            break;
    }
    return type;
}
@end
