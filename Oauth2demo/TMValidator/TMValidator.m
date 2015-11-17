//
//  TMValidator.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/15.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidator.h"

@implementation TMValidator

+ (instancetype)validator
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.fields = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)addField:(TMValidatorField *)field
{
    NSAssert([field isKindOfClass:[TMValidatorField class]], @"field is not kind of TMValidatorField");
    
    [self.fields addObject:field];
    
    return self;
}

- (BOOL)runWithSuccesses:(void (^)(NSArray *))success andFailure:(void (^)(NSArray *))failure
{
    NSMutableArray *successes = [NSMutableArray array];
    NSMutableArray *errors    = [NSMutableArray array];
    
    BOOL result = YES;
    TMValidatorField *field;
    for (int i = 0; i < self.fields.count; i++)
    {
        field = [self.fields objectAtIndex:i];
        
        if ( [field run] )
        {
            [successes addObject:field];
        } else
        {
            result = NO;
            [errors addObject:field];
        }
    }
    
    if (nil != success)
    {
        success(successes);
    }
    if (nil != failure)
    {
        failure(errors);
    }
    return result;
}

- (BOOL)runWithFailure:(void (^)(NSArray *))failure
{
    return [self runWithSuccesses:nil andFailure:failure];
}

- (BOOL)run
{
    return [self runWithSuccesses:nil andFailure:nil];
}

- (void)dealloc
{
    self.fields = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: fields=%@>", NSStringFromClass(self.class), self.fields];
}

@end
