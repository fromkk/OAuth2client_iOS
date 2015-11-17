//
//  TMValidatorRuleNumericMin.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleNumericMin.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleIsNumeric.h"

@implementation TMValidatorRuleNumericMin

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeNumericMin;
    }
    
    return self;
}

+ (instancetype)ruleWithNumeric:(NSNumber *)numeric
{
    TMValidatorRuleNumericMin *instance = [self rule];
    instance.numeric = numeric;
    return  instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withNumeric:self.numeric];
}

+ (BOOL)run:(NSString *)string withNumeric:(NSNumber *)numeric
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == numeric)
    {
        NSLog(@"numeric is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    if ( NO == [TMValidatorRuleIsNumeric run:string] )
    {
        NSLog(@"string(%@) is not numeric. %s %d", string, __FUNCTION__, __LINE__);
        return NO;
    }
    
    NSNumber *value = [NSNumber numberWithFloat:string.floatValue];
    NSComparisonResult result = [value compare:numeric];
    return result == NSOrderedSame || result == NSOrderedDescending;
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.numericMin", @"TMValidatorError", @"numericMin");
    return [NSString stringWithFormat:format, label, self.numeric];
}

- (void)dealloc
{
    self.numeric = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: numeric=%@>", NSStringFromClass(self.class), self.numeric];
}

@end
