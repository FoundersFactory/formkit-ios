//
//  FFKValidator.h
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFKInput;
@class FFKValidatorError;

@interface FFKValidator : NSObject

typedef BOOL (^FFKValidatorHandler)(FFKValidator *validator, FFKInput *input, FFKValidatorError **error);

@property (readonly, strong) FFKValidatorHandler handler;

- (instancetype)initWithHandler:(FFKValidatorHandler)handler;
+ (instancetype)validatorWithHandler:(FFKValidatorHandler)handler;
+ (instancetype)emailValidator;
+ (instancetype)requiredValidator;
+ (instancetype)phoneNumberValidator;
+ (instancetype)fullNameValidator;

@end
