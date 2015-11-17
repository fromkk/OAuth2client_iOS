//
//  ViewController.h
//  Oauth2demo
//
//  Created by Kazuya Ueoka on 2015/11/13.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXOAuth2.h"
#import "OAauth_config.h"
#import "TMValidateTextField.h"

@interface ViewController : UIViewController <NXOAuth2ClientDelegate, UITextFieldDelegate>

@property (nonatomic) TMValidateTextField *emailTextField;
@property (nonatomic) TMValidateTextField *passwordTextField;
@property (nonatomic) UIButton *loginButton;
@property (nonatomic) UIButton *skipButton;

@end

