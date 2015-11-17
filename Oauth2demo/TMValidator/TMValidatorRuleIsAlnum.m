//
//  TMValidatorRuleAlnum.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleIsAlnum.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleMatchPattern.h"

@implementation TMValidatorRuleIsAlnum

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeIsAlnum;
    }
    
    return self;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string];
}

+ (BOOL)run:(NSString *)string
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    return [TMValidatorRuleMatchPattern run:string withPattern:@"^[a-zA-Z0-9]+$"];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.isAlnum", @"TMValidatorError", @"isAlnum");
    return [NSString stringWithFormat:format, label];
}

@end
