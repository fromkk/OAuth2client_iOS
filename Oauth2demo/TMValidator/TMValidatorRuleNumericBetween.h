//
//  TMValidatorRuleNumericBetween.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleNumericBetween : TMValidatorRule

@property (nonatomic) NSNumber *numericMin;
@property (nonatomic) NSNumber *numericMax;

+ (instancetype)ruleWithNumericMin:(NSNumber *)numericMin andNumericMax:(NSNumber *)numericMax;
+ (BOOL)run:(NSString *)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString *)string withNumericMin:(NSNumber *)numericMin andNumericMax:(NSNumber *)numericMax;

@end
