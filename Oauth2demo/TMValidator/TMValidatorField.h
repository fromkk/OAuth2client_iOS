//
//  TMValidatorField.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMValidatorRule.h"

@interface TMValidatorField : NSObject

@property (nonatomic) NSString *label;
@property (nonatomic) NSString *value;
@property (nonatomic) UIView *element;
@property (nonatomic) NSMutableArray *rules;
@property (nonatomic) NSMutableArray *errors;

+ (instancetype)fieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(UIView *)element;
+ (instancetype)fieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(UIView *)element andRules:(NSArray *)rules;
+ (instancetype)requiredFieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(UIView *)element;
- (instancetype)addRule:(TMValidatorRule *)rule;
- (instancetype)addRules:(NSArray *)rules;
- (BOOL)run;

@end
