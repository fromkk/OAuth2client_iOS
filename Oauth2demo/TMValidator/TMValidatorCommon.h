//
//  TMValidatorCommon.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#ifndef TMValidatorCommon_h
#define TMValidatorCommon_h

typedef enum
{
    TMValidatorErrorCodeRequired = 1,
    TMValidatorErrorCodeExactLength,
    TMValidatorErrorCodeMinLength,
    TMValidatorErrorCodeMaxLength,
    TMValidatorErrorCodeIsNumeric,
    TMValidatorErrorCodeIsAlphabet,
    TMValidatorErrorCodeIsAlnum,
    TMValidatorErrorCodeNumericMin,
    TMValidatorErrorCodeNumericMax,
    TMValidatorErrorCodeNumericBetween,
    TMValidatorErrorCodeMatchValue,
    TMValidatorErrorCodeMatchPattern,
    TMValidatorErrorCodeEmail
} TMValidatorErrorCode;

#ifndef TMValidatorErrorDomain
#define TMValidatorErrorDomain @"TMValidatorError"
#endif

#endif /* TMValidatorCommon_h */
