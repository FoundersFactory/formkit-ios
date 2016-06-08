//
//  FFKTextInput.m
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTextInput.h"
#import "FormKit.h"
#import "FFKTextInputTableViewCell.h"

@implementation FFKTextInput

@dynamic value;

+ (instancetype)textInputWithConfigurationHandler:(void(^)(FFKTextInput *input))handler
{
    FFKTextInput *input = [FFKTextInput new];
    input.focusable = YES;
    input.viewCellClass = [FFKTextInputTableViewCell class];
    handler(input);
    
    return input;
}

@end
