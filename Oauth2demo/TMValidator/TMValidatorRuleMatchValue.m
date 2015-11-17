//
//  TMValidatorRuleMatchValue.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleMatchValue.h"
#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleMatchValue

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeMatchValue;
    }
    
    return self;
}

+ (instancetype)ruleWithValue:(NSString *)value
{
    TMValidatorRuleMatchValue *instance = [self rule];
    instance.value = value;
    return instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withValue:self.value];
}

+ (BOOL)run:(NSString *)string withValue:(NSString *)value
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    return [string isEqualToString:value];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.matchValue", @"TMValidatorError", @"matchValue");
    return [NSString stringWithFormat:format, label, self.value];
}

- (void)dealloc
{
    self.value = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: value=%@>", NSStringFromClass(self.class), self.value];
}

@end
