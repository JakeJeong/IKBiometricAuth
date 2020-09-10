//
//  IKBiometricAuthResult.h
//  IKBiometricAuthAuth
//
//  Created by ikjeong on 2020/09/10.
//  Copyright © 2020 ikjeong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IKBiometricAuthResultType) {
    AuthenticationNotReady = -1,
    AuthenticationSuccess = 99999,
    AuthenticationFailed = kLAErrorAuthenticationFailed,
    UserCancel = kLAErrorUserCancel,
    UserFallback = kLAErrorUserFallback,
    SystemCancel = kLAErrorSystemCancel,
    PasscodeNotSet = kLAErrorPasscodeNotSet,
    AppCancel = kLAErrorAppCancel,
    InvalidContext = kLAErrorInvalidContext,
    NotAvailable = kLAErrorBiometryNotAvailable,
    NotEnrolled = kLAErrorBiometryNotEnrolled,
    BiometryLockout = kLAErrorBiometryLockout,
    NotInteractive = kLAErrorNotInteractive
};

/// 생체인증 결과를 담는 오브젝트 클래스
@interface IKBiometricAuthResult : NSObject

/// 생체인증 결과 Error로 리턴
@property (class, readonly, nonatomic) IKBiometricAuthResult * (^result)(NSError*);

/// 생체인증 결과 통과 리턴
@property (class, readonly, nonatomic) IKBiometricAuthResult * (^resultSuccess)(void);

/// 에러 메세지
@property (nonatomic, readonly) NSString * message;

/// 에러 코드 / OSStatus값
@property (nonatomic, readonly) IKBiometricAuthResultType resultType;
@end

NS_ASSUME_NONNULL_END
