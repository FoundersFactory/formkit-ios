//
//  FFKValidator.m
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKValidator.h"
#import "FormKit.h"

@implementation FFKValidator

- (instancetype)initWithHandler:(FFKValidatorHandler)handler
{
    if (self = [super init]) {
        
        _handler = handler;
    }
    
    return self;
}

+ (instancetype)validatorWithHandler:(FFKValidatorHandler)handler
{
    return [[FFKValidator alloc] initWithHandler:handler];
}

+ (instancetype)requiredValidator
{
    return [FFKValidator validatorWithHandler:^BOOL(FFKValidator *validator, FFKInput *input, FFKValidatorError **error) {
        
        FFKValidatorError *requiredError = [FFKValidatorError validatorErrorWithInput:input localizedDescription:[NSString stringWithFormat:@"%@ is required", input.titleText] recoverySuggestion:@"Fill in the field and try again."];
        
        if ([input isKindOfClass:[FFKTextInput class]]) {
            if ([[(FFKTextInput *)input value] isEqualToString:@""] || !input.value) {
                *error = requiredError;
                return NO;
            }
        } else if (!input.value) {
            *error = requiredError;
            return NO;
        } else {
            return YES;
        }
        
        return YES;
    }];
}

+ (instancetype)emailValidator
{
    return [FFKValidator validatorWithHandler:^BOOL(FFKValidator *validator, FFKInput *input, FFKValidatorError **error) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
        *error = [FFKValidatorError validatorErrorWithInput:input localizedDescription:@"Email address is invalid" recoverySuggestion:@"Change the email address and try again."];
        
        return [predicate evaluateWithObject:input.value];
    }];
}

+ (instancetype)phoneNumberValidator
{
    return nil;
}

+ (instancetype)fullNameValidator
{
    return nil;
}

@end
