//
//  TMValidatorRuleRequired.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleRequired.h"
#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleRequired

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeRequired;
    }
    
    return self;
}

+ (BOOL)run:(NSString *)string
{
    return ![TMValidatorRuleIsEmpty run:string];
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.required", @"TMValidatorError", @"required");
    return [NSString stringWithFormat:format, label];
}

@end
