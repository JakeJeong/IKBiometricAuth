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
@interface IKBiometricAuth : NSObject

/// 생체인증하기 결과 동기로 받기
@property (class, nonatomic, readonly) IKBiometricAuthResult *(^showAuthentication)(BiometricAuthType, NSString* _Nonnull reason,NSString * _Nullable fallbackTitle);

/// 생체인증하기 블럭함수
@property (class, nonatomic, readonly) void(^showAuthenticationWithResult)(IKBiometricAuthResult * _Nullable __strong*_Nullable result,BiometricAuthType,NSString*_Nullable reason,NSString*_Nullable fallbackTitle);

/// 생체인증하기 함수 (결과 블럭으로 받기)
@property (class, nonatomic, readonly) void(^showAuthenticationWithResultBlock)(BiometricAuthType,NSString*_Nullable reason,NSString*_Nullable fallbackTitle,ResultBlock resultBlock);

/// 생체인증 타입 리턴 (none, touchid, faceid)
@property (class, nonatomic, readonly) BiometricType (^BiometricType)(void);
//
///// 생체인증 진행하기
///// @param reason 메세지
///// @param fallbackTitle 인증 실패후 문구
//IKBiometricAuthResult* IKBiometricAuthShowAuthentication(NSString*_Nullable reason,NSString*_Nullable fallbackTitle);
//
///// 생체인증 진행하고 블럭으로 결과 받기
///// @param result 결과값 리턴 객체
///// @param reason 메세지
///// @param fallbackTitle 인증 실패후 문구
//void IKBiometricAuthAuthentication(IKBiometricAuthResult * _Nullable __strong*_Nullable result,NSString*_Nullable reason,NSString*_Nullable fallbackTitle);
//
//
////IKBiometricAuthResult* IKBiometricAuthAddCredential(NSString*_Nonnull*_Nonnull alias, NSString*_Nonnull*_Nonnull credentialData);
////IKBiometricAuthResult* IKBiometricAuthReadCredential(NSString*_Nonnull*_Nonnull alias);
@end

NS_ASSUME_NONNULL_END
