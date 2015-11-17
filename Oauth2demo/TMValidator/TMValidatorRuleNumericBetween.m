//
//  TMValidatorRuleNumericBetween.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleNumericBetween.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleIsNumeric.h"

@implementation TMValidatorRuleNumericBetween

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeNumericBetween;
    }
    
    return self;
}

+ (instancetype)ruleWithNumericMin:(NSNumber *)numericMin andNumericMax:(NSNumber *)numericMax
{
    TMValidatorRuleNumericBetween *instance = [self rule];
    instance.numericMin = numericMin;
    instance.numericMax = numericMax;
    return  instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withNumericMin:self.numericMin andNumericMax:self.numericMax];
}

+ (BOOL)run:(NSString *)string withNumericMin:(NSNumber *)numericMin andNumericMax:(NSNumber *)numericMax
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == numericMin || nil == numericMax)
    {
        NSLog(@"numericMin ow numericMax is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    if ( NO == [TMValidatorRuleIsNumeric run:string] )
    {
        NSLog(@"string(%@) is not numeric. %s %d", string, __FUNCTION__, __LINE__);
        return NO;
    }
    
    NSNumber *value = [NSNumber numberWithFloat:string.floatValue];
    NSComparisonResult resultMin = [value compare:numericMin];
    NSComparisonResult resultMax = [value compare:numericMax];
    
    return (resultMin == NSOrderedSame || resultMin == NSOrderedDescending) && (resultMax == NSOrderedSame || resultMax == NSOrderedAscending);
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.numericBetween", @"TMValidatorError", @"numericBetween");
    return [NSString stringWithFormat:format, label, self.numericMin, self.numericMax];
}

- (void)dealloc
{
    self.numericMin = nil;
    self.numericMax = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: numericMin=%@ numericMax=%@>", NSStringFromClass(self.class), self.numericMin, self.numericMax];
}

@end
