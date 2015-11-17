//
//  TMValidateTextField.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/17.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMValidator.h"

@interface TMValidateTextField : UITextField
{
    TMValidatorField *_field;
}

@property (nonatomic) NSString *label;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithRules:(NSArray *)rules;
- (instancetype)initWithCoder:(NSCoder *)aDecoder UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder andRules:(NSArray *)rules;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame andRules:(NSArray *)rules;
- (instancetype)addRule:(TMValidatorRule *)rule;
- (instancetype)addRules:(NSArray *)rules;
- (BOOL)valid;
- (NSArray *)errors;

@end
