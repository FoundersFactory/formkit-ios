//
//  FFKInput.h
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFKValidator;
@class FFKValidatorError;
@class FFKInputTableViewCell;
@class FFKTableRow;
@class FFKFormatter;

@interface FFKInput : NSObject

/**
 The name of the input, useful for identifying it.
 */
@property (nonatomic, strong) NSString *name;

/**
 The value of the input.
 */
@property (nonatomic, strong) id value;

/**
 The title displayed to the user alongside the input.
 */
@property (nonatomic, strong) NSString *titleText;

/**
 The detail text displayed to the user alongside the input.
 */
@property (nonatomic, strong) NSString *detailText;

/**
 The accessory text displayed to the user. Depends on cell support if it's shown or not.
 */
@property (nonatomic, strong) NSString *accessoryText;

/**
 The icon or image displayed to the user alongside the input/
 */
@property (nonatomic, strong) UIImage *image;

/**
 Whether the entire input is checkable or not. If YES -- and the user taps the input -- a checkmark accessory will be placed beside it.
 */
@property (nonatomic, assign, getter = isCheckable) BOOL checkable;

@property (nonatomic, assign, getter=isChecked) BOOL checked;

/**
 Whether the input is disabled.
 */
@property (nonatomic, assign, getter = isDisabled) BOOL disabled;

/**
 The validator belonging to the input.
 */
@property (nonatomic, strong) FFKValidator *validator;

@property (nonatomic, strong) FFKValidatorError *validatorError;

@property (nonatomic, assign, getter=isFocusable) BOOL focusable;

@property (nonatomic, strong) FFKFormatter *formatter;

/**
 The view class used to represent the input.
 */
@property (nonatomic, strong) Class viewCellClass;

@property (nonatomic, weak) FFKTableRow *row;

/**
 Store additional objects against the input.
 */
@property (nonatomic, strong) id context;

/**
 Whether the input is a suggestion from an autocompleter.
 */
@property (nonatomic, assign, getter=isSuggestion) BOOL suggestion;

+ (instancetype)inputWithConfigurationHandler:(void (^)(FFKInput *input))handler;
- (void)validate;

@end
