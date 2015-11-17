//
//  TMValidatorRuleIsAlphabet.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleIsAlphabet.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleMatchPattern.h"

@implementation TMValidatorRuleIsAlphabet

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeIsAlphabet;
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
    
    return [TMValidatorRuleMatchPattern run:string withPattern:@"^[a-zA-Z]+$"];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.isAlphabet", @"TMValidatorError", @"isAlphabet");
    return [NSString stringWithFormat:format, label];
}

@end
