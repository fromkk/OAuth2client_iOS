//
//  TMValidatorRuleMatchValue.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleMatchValue : TMValidatorRule

@property (nonatomic) NSString *value;

+ (instancetype)ruleWithValue:(NSString *)value;
+ (BOOL)run:(NSString *)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString *)string withValue:(NSString *)value;

@end
