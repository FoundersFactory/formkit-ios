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

@end
