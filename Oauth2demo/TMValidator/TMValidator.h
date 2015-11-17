//
//  TMValidator.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/15.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMValidatorCommon.h"
#import "TMValidatorField.h"
#import "TMValidatorRuleRequired.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleMinLength.h"
#import "TMValidatorRuleMaxLength.h"
#import "TMValidatorRuleExactLength.h"
#import "TMValidatorRuleIsNumeric.h"
#import "TMValidatorRuleIsAlphabet.h"
#import "TMValidatorRuleIsAlnum.h"
#import "TMValidatorRuleNumericMin.h"
#import "TMValidatorRuleNumericMax.h"
#import "TMValidatorRuleNumericBetween.h"
#import "TMValidatorRuleMatchValue.h"
#import "TMValidatorRuleMatchPattern.h"
#import "TMValidatorRuleEmail.h"

@interface TMValidator : NSObject

@property (nonatomic) NSMutableArray *fields;

+ (instancetype)validator;

- (instancetype)addField:(TMValidatorField *)field;
- (BOOL)runWithSuccesses:(void (^)(NSArray *successes))success andFailure:(void (^)(NSArray *errors))failure;
- (BOOL)runWithFailure:(void (^)(NSArray *errors))failure;
- (BOOL)run;

@end
