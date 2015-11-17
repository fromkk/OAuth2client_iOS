//
//  TMValidatorField.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorField.h"
#import "TMValidatorRuleRequired.h"

@implementation TMValidatorField

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.value = nil;
        self.label = nil;
        self.element = nil;
        self.rules = [NSMutableArray array];
        self.errors = nil;
    }
    
    return self;
}

+ (instancetype)fieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(UIView *)element andRules:(NSArray *)rules
{
    TMValidatorField *instance = [[self alloc] init];
    instance.value = value;
    instance.label = label;
    instance.element = element;
    instance.errors = [NSMutableArray array];
    if (nil != rules && [rules isKindOfClass:[NSArray class]])
    {
        [instance addRules:rules];
    }
    return instance;
}

+ (instancetype)fieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(UIView *)element
{
    return [self fieldWithValue:value andLabel:label andElement:element andRules:nil];
}

+ (instancetype)requiredFieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(UIView *)element
{
    return [self fieldWithValue:value andLabel:label andElement:element andRules:@[[TMValidatorRuleRequired rule]]];
}

- (instancetype)addRule:(TMValidatorRule *)rule
{
    if ([rule isKindOfClass:[TMValidatorRule class]])
    {
        [self.rules addObject:rule];
    } else
    {
        NSLog(@"rule %@ is not kind of TMValidatorRule!! %s %d", rule, __FUNCTION__, __LINE__);
    }

    return self;
}

- (instancetype)addRules:(NSArray *)rules
{
    TMValidatorRule *rule;
    for (int i = 0; i < rules.count; i++)
    {
        rule = [rules objectAtIndex:i];
        [self addRule:rule];
    }
    
    return self;
}

- (BOOL)run
{
    BOOL result = YES;
    TMValidatorRule *rule;
    for (int i = 0; i < self.rules.count; i++)
    {
        rule = [self.rules objectAtIndex:i];
        if ( NO == [rule run:self.value] )
        {
            result = NO;
            [self.errors addObject:[NSError errorWithDomain:TMValidatorErrorDomain code:rule.errorCode userInfo:@{NSLocalizedDescriptionKey: [rule errorMessageWithLabel:self.label]}]];
        }
    }
    
    return result;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: label=%@ value=%@ element=%@ rules=%@ errors=%@>", NSStringFromClass(self.class), self.label, self.value, self.element, self.rules, self.errors];
}

- (void)dealloc
{
    self.label   = nil;
    self.value   = nil;
    self.element = nil;
    self.rules   = nil;
    self.errors  = nil;
}

@end
