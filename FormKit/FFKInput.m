//
//  FFKInput.m
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKInput.h"
#import "FormKit.h"
#import <TableKit/TableKit.h>

@implementation FFKInput

+ (instancetype)inputWithConfigurationHandler:(void (^)(FFKInput *))handler
{
    FFKInput *input = [FFKInput new];
    input.viewCellClass = [FFKInputTableViewCell class];
    handler(input);

    if (!input.value) {
        [input validate];
    }
    
    return input;
}

- (void)configureView:(FFKInputTableViewCell *)view
{
    view.input = self;
    view.textLabel.text = self.titleText;
    view.detailTextLabel.text = self.detailText;
    view.imageView.image = self.image;
    
    if (self.validatorError) {
        [view setValidatorErrorStyleEnabled:YES];
    } else {
        [view setValidatorErrorStyleEnabled:NO];
    }
    
    if (self.isCheckable) {
        if ([self.value isEqualToNumber:@(1)]) {
            [view check];
        } else {
            [view uncheck];
        }
    }
}

- (void)validate
{
    FFKValidator *validator = self.validator;
    FFKValidatorError *error = nil;
    
    if (validator.handler) {
        
        if (!validator.handler(validator, self, &error)) {
            self.validatorError = error;
        } else {
            self.validatorError = nil;
        }
        
        self.row.dirty = YES;
    }
}

- (void)setValue:(id)value
{
    [self willChangeValueForKey:@"value"];
    _value = value;
    [self validate];
    [self didChangeValueForKey:@"value"];
}

@end
