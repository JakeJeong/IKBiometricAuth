//
//  IKBiometricAuth.h
//  IKBiometricAuth
//
//  Created by ikjeong on 2020/09/10.
//  Copyright © 2020 ikjeong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IKBiometricAuthResult.h"
//! Project version number for IKBiometricAuth.
FOUNDATION_EXPORT double IKBiometricAuthVersionNumber;

//! Project version string for IKBiometricAuth.
FOUNDATION_EXPORT const unsigned char IKBiometricAuthVersionString[];


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BiometricType) {
    BiometricTypeNone,
    BiometricTypeTouchID,
    BiometricTypeFaceID,
    BiometricTypeUnknown
};
typedef NS_ENUM(NSUInteger, BiometricAuthType) {
    BiometricAuthOnly,
    BiometricAuthWithPasscode
};


typedef void(^EvaluateBlock)(NSString*_Nonnull* _Nonnull reason,NSString *_Nullable* _Nullable fallbackTitle);
typedef void(^ResultBlock)(IKBiometricAuthResult * result);

/// 생체인증을 체크하는 클래스
/// Class to check biometric authentication
@interface IKBiometricAuth : NSObject

/// 생체 인식 검증 결과를 동기화로 수신
/// Receive biometric verification results as sync
@property (class, nonatomic, readonly) IKBiometricAuthResult *(^showAuthentication)(BiometricAuthType, NSString* _Nonnull reason,NSString * _Nullable fallbackTitle);

/// 생체인증하기 블럭함수
/// Biometric authentication block function
@property (class, nonatomic, readonly) void(^showAuthenticationWithResult)(IKBiometricAuthResult * _Nullable __strong*_Nullable result,BiometricAuthType,NSString*_Nullable reason,NSString*_Nullable fallbackTitle);

/// 생체인증하기 함수 (결과 블럭으로 받기)
/// Biometric authentication function (receive as result block)
@property (class, nonatomic, readonly) void(^showAuthenticationWithResultBlock)(BiometricAuthType,NSString*_Nullable reason,NSString*_Nullable fallbackTitle,ResultBlock resultBlock);

/// 생체인증 타입 리턴 (none, touchid, faceid)
/// Return biometric authentication type (none, touchid, faceid)
@property (class, nonatomic, readonly) BiometricType (^BiometricType)(void);

@end

NS_ASSUME_NONNULL_END
