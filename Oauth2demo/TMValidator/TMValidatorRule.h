//
//  TMValidatorRule.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMValidatorCommon.h"

@protocol TMValidatorRuleProtocol <NSObject>

- (NSString *)errorMessageWithLabel:(NSString *)label;

@optional
- (BOOL)run:(NSString *)string;
+ (BOOL)run:(NSString *)string;

@end

@interface TMValidatorRule : NSObject <TMValidatorRuleProtocol>
{
    TMValidatorErrorCode _errorCode;
}

+ (instancetype)rule;

@property (nonatomic, readonly) TMValidatorErrorCode errorCode;

@end
