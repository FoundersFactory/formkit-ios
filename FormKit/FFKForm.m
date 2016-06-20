//
//  FFKForm.m
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKForm.h"
#import "FormKit.h"
#import "FFKInput.h"    
#import "FFKFieldset.h"

@implementation FFKForm

- (NSArray <FFKInput *> *)inputsForName:(NSString *)name
{
    NSMutableArray *inputs = [NSMutableArray array];
    
    for (FFKFieldset *fieldset in self.fieldsets) {
        
        for (FFKInput *input in fieldset.inputs) {
            if ([input.name isEqualToString:name]) {
                [inputs addObject:input];
            }
        }
    }
    
    return inputs;
}

- (FFKInput *)firstInputForName:(NSString *)name
{
    return [[self inputsForName:name] firstObject];
}

- (NSDictionary *)valuesForFieldset:(FFKFieldset *)fieldset
{
    NSMutableDictionary *values = [NSMutableDictionary new];
    
    for (FFKInput *input in fieldset.inputs) {
        
        if (!values[input.name] && input.value && input.name) {
            if ((input.isCheckable && input.isChecked) || (!input.isCheckable)) {
                values[input.name] = input.value;
            }
        } else if(input.value && input.name) {

            if ((input.isCheckable && input.isChecked) || (!input.isCheckable)) {
                
                id value = values[input.name];
                
                if ([value isKindOfClass:[NSArray class]]) {
                    value = [value arrayByAddingObject:input.value];
                } else {
                    value = @[value, input.value];
                }
                
                values[input.name] = value;
            }
        }
    }
    
    return values;
}

- (NSDictionary *)valuesDictionary
{
    NSMutableDictionary *values = [NSMutableDictionary dictionary];
    
    for (FFKFieldset *fieldset in self.fieldsets) {
        [values addEntriesFromDictionary:[self valuesForFieldset:fieldset]];
    }
    
    return values;
}

@end
