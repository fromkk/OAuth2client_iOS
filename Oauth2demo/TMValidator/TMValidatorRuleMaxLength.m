//
//  TMValidatorRuleMaxLength.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleMaxLength.h"
#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleMaxLength

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeMaxLength;
    }
    
    return self;
}

+ (instancetype)ruleWithLength:(NSNumber *)length
{
    TMValidatorRuleMaxLength *instance = [self rule];
    instance.length = length;
    return instance;
}

+ (BOOL)run:(NSString *)string withLength:(NSNumber *)length
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == length)
    {
        NSLog(@"length is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    return string.length <= length.integerValue;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withLength:self.length];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.maxLength", @"TMValidatorError", @"maxLength");
    return [NSString stringWithFormat:format, label, self.length];
}

- (void)dealloc
{
    self.length = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: length=%@>", NSStringFromClass(self.class), self.length];
}

@end
