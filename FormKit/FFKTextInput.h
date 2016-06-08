//
//  FFKTextInput.h
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKInput.h"

@class FFKTextAutocompleter;
@class FFKValidator;
@protocol FFKTextAutocompleterProtocol;

/**
 Allows input for text or numbers.
 */
@interface FFKTextInput : FFKInput

@property (nonatomic, strong) NSString *value;

/**
 The placeholder text displayed to the user when the value is nil.
 */
@property (nonatomic, strong) NSString *placeholderText;

/**
 The type of keyboard to be presented when focused.
 */
@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;

@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;

/**
 The autocompleter. Displays suggestions below the input.
 */
@property (nonatomic, strong) id <FFKTextAutocompleterProtocol> textAutocompleter;

+ (instancetype)textInputWithConfigurationHandler:(void(^)(FFKTextInput *input))handler;

@end
