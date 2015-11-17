//
//  TMValidatorRuleMatchPattern.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleMatchPattern : TMValidatorRule

@property (nonatomic) NSString *pattern;

+ (instancetype)ruleWithPattern:(NSString *)pattern;
+ (BOOL)run:(NSString *)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString *)string withPattern:(NSString *)pattern;

@end
