//
//  TMValidatorRuleNumericMax.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleNumericMax : TMValidatorRule

@property (nonatomic) NSNumber *numeric;

+ (instancetype)ruleWithNumeric:(NSNumber *)numeric;
+ (BOOL)run:(NSString *)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString *)string withNumeric:(NSNumber *)numeric;

@end
