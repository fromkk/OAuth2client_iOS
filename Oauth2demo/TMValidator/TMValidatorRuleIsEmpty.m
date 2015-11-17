//
//  TMValidatorRuleIsEmpty.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleIsEmpty

+ (BOOL)run:(NSString *)string
{
    if (nil == string)
    {
        return YES;
    }
    
    if (NO == [string isKindOfClass:[NSString class]] )
    {
        NSLog(@"string(%@) is not NSString : %s %d", string, __FUNCTION__, __LINE__);
        return NO;
    }
    
    return 0 == string.length;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.isEmpty", @"TMValidatorError", @"isEmtpy");
    return [NSString stringWithFormat:format, label];
}

@end
