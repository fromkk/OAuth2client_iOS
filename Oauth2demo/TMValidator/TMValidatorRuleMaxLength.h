//
//  TMValidatorRuleMaxLength.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleMaxLength : TMValidatorRule

@property (nonatomic) NSNumber *length;

+ (instancetype)ruleWithLength:(NSNumber *)length;
+ (BOOL)run:(NSString *)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString *)string withLength:(NSNumber *)length;

@end
