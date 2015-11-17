//
//  TMValidatorRule.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@implementation TMValidatorRule

@synthesize errorCode = _errorCode;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = 0;
    }
    
    return self;
}

+ (instancetype)rule
{
    TMValidatorRule *instance = [[self alloc] init];
    return instance;
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    return @"";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>", NSStringFromClass(self.class)];
}

@end
