//
//  UIAlertController+blocks.h
//  Oauth2demo
//
//  Created by Kazuya Ueoka on 2015/11/17.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController(blocks)

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message viewController:(UIViewController *)viewController;

@end
