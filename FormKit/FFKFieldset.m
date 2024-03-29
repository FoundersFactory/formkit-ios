//
//  FFKFieldset.m
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKFieldset.h"
#import "FormKit.h"

@implementation FFKFieldset

+ (instancetype)fieldsetWithConfigurationHandler:(FFKFieldsetConfigurationHandler)configurationHandler
{
    FFKFieldset *fieldset = [FFKFieldset new];
    configurationHandler(fieldset);
    
    return fieldset;
}

- (BOOL)inputsContainValidatorErrors
{
    for (FFKInput *input in self.inputs) {
        if (input.validatorError) {
            return YES;
        }
    }
    
    return NO;
}

@end
