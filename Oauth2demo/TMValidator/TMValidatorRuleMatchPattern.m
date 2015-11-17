//
//  TMValidatorRuleMatchPattern.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleMatchPattern.h"
#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleMatchPattern

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeMatchPattern;
    }
    
    return self;
}

+ (instancetype)ruleWithPattern:(NSString *)pattern
{
    TMValidatorRuleMatchPattern *instance = [self rule];
    instance.pattern = pattern;
    return instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withPattern:self.pattern];
}

+ (BOOL)run:(NSString *)string withPattern:(NSString *)pattern
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == pattern)
    {
        NSLog(@"pattern is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error)
    {
        NSLog(@"%@ %s %d", error, __FUNCTION__, __LINE__);
        return NO;
    }
    
    return 0 < [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.matchPattern", @"TMValidatorError", @"matchPattern");
    return [NSString stringWithFormat:format, label, self.pattern];
}

- (void)dealloc
{
    self.pattern = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: pattern=%@>", NSStringFromClass(self.class), self.pattern];
}

@end
