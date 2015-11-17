//
//  TMValidateTextField.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/17.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidateTextField.h"

@implementation TMValidateTextField

- (instancetype)initWithRules:(NSArray *)rules
{
    self = [super init];
    if (self)
    {
        [self _initialize];
        [self addRules:rules];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder andRules:(NSArray *)rules
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _initialize];
        [self addRules:rules];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andRules:(NSArray *)rules
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _initialize];
        [self addRules:rules];
    }
    
    return self;
}

- (void)_initialize
{
    if (!_field)
    {
        _field = [TMValidatorField fieldWithValue:self.text andLabel:self.label andElement:self];
        [self addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self];
    }
}

- (void)setLabel:(NSString *)label
{
    _label = label;
    _field.label = _label;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    _field.value = text;
}

- (void)textDidChanged:(NSNotification *)notif
{
    _field.value = self.text;
}

- (BOOL)valid
{
    return [_field run];
}

- (NSArray *)errors
{
    return [_field errors];
}

- (instancetype)addRule:(TMValidatorRule *)rule
{
    [_field addRule:rule];
    return self;
}

- (instancetype)addRules:(NSArray *)rules
{
    [_field addRules:rules];
    return self;
}

- (void)dealloc
{
    _label = nil;
    _field = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}

@end
