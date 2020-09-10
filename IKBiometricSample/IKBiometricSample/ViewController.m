//
//  ViewController.m
//  IKBiometricSample
//
//  Created by ikjeong on 2020/09/10.
//  Copyright © 2020 jakejeong. All rights reserved.
//

#import "ViewController.h"
#import <IKBiometricAuth/IKBiometricAuth.h>

@interface ViewController () {
@private
    NSMutableString * statusMessage;
}

@property (weak, nonatomic) IBOutlet UIButton * authBtn;
@property (weak, nonatomic) IBOutlet UILabel * typeLabel;
@property (weak, nonatomic) IBOutlet UITextView * statusTextView;

@property (strong, nonatomic, setter=setMessage:) NSString * message;

@property (strong, nonatomic) NSString * reason;
@property (strong, nonatomic) NSString * fallbackTitle;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reason = @"생체인증";
    self.fallbackTitle =  @"암호입력";
    
    statusMessage = [[NSMutableString alloc]init];
    
    BiometricType type = IKBiometricAuth.BiometricType();
    if (type == BiometricTypeTouchID) {
        self.message = @"BiometricTypeTouchID";
        self.typeLabel.text = @"BiometricTypeTouchID";;
    }
    else if (type == BiometricTypeFaceID) {
        self.message = @"BiometricTypeFaceID";
        self.typeLabel.text = @"BiometricTypeFaceID";
    }
}

- (IBAction)didTouchAuthAction:(id)sender {
    NSUInteger codeCase = 0;
    if (codeCase == 0 || codeCase == 1) {
        [self case1];
    }
    else if (codeCase == 2) {
        [self case2];
    }
    if (codeCase >= 3) {
        [self case3];
    }
}
- (void)case1 {
    IKBiometricAuthResult * result;
    IKBiometricAuth.showAuthenticationWithResult(&result,BiometricAuthWithPasscode,self.reason,self.fallbackTitle);
    if (result.resultType == AuthenticationSuccess) {
        self.message = @"[Success]";
    } else {
        self.message =  [NSString stringWithFormat:@"[Failed] \n%@",result.message];
    }
}
- (void)case2 {
    IKBiometricAuthResult * result = IKBiometricAuth.showAuthentication(BiometricAuthWithPasscode, self.reason, self.fallbackTitle);
    if (result.resultType == AuthenticationSuccess) {
    self.message = @"[Success]";
    } else {
    self.message =  [NSString stringWithFormat:@"[Failed] \n%@",result.message];
    }
}
- (void)case3 {
    IKBiometricAuth.showAuthenticationWithResultBlock(BiometricAuthWithPasscode,self.reason, self.fallbackTitle, ^(IKBiometricAuthResult * _Nonnull result) {
        if (result.resultType == AuthenticationSuccess) {
            self.message = @"[Success]";
        } else {
            self.message =  [NSString stringWithFormat:@"[Failed] \n%@",result.message];
        }
    });
}
#pragma mark - for Log
- (void)setMessage:(NSString *)message {
    [statusMessage appendString:@"\n"];
    [statusMessage appendString:message];
    self.statusTextView.text = statusMessage;
}
@end
