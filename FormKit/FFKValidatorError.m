//
//  FFKValidatorError.m
//  FormKit
//
//  Created by Phillip Caudell on 06/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKValidatorError.h"
#import "FormKit.h"

@implementation FFKValidatorError

+ (instancetype)validatorErrorWithInput:(FFKInput *)input localizedDescription:(NSString *)localisedDescription recoverySuggestion:(NSString *)recoverySuggestion
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    
    if (localisedDescription) {
        userInfo[NSLocalizedDescriptionKey] = localisedDescription;
    }
    
    if (recoverySuggestion) {
        userInfo[NSLocalizedRecoverySuggestionErrorKey] = recoverySuggestion;
    }
    
    FFKValidatorError *error = [[FFKValidatorError alloc] initWithDomain:FFKFormKitErrorDomain code:400 userInfo:userInfo];
    error.input = input;
    
    return error;
}

@end
