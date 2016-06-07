//
//  FFKFieldset.h
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFKInput;

/**
 Represents a logical group of inputs in a form.
 */
@interface FFKFieldset : NSObject

typedef void (^FFKFieldsetAdvancementCallback)(FFKFieldset *nextFieldset);
typedef void (^FFKFieldsetAdvancementHandler)(FFKFieldset *fieldset, FFKFieldsetAdvancementCallback callback);
typedef void (^FFKFieldsetConfigurationHandler)(FFKFieldset *fieldset);

/**
 The name of the fieldset, useful for identifying it.
 */
@property (nonatomic, strong) NSString *name;

/**
 The title that is displayed to the user.
 */
@property (nonatomic, strong) NSString *titleText;

/**
 Additional text that is used to explain the fieldset to the user.
 */
@property (nonatomic, strong) NSString *detailText;

/**
 An icon or image to be presented with the fieldset.
 */
@property (nonatomic, strong) UIImage *image;

/**
 Additional text that is used to explain what the user should do. E.g. "Select up to 3".
 */
@property (nonatomic, strong) NSString *hintText;

/**
 The inputs that are displayed within the fieldset
 */
@property (nonatomic, strong) NSArray <FFKInput *> *inputs;

/**
 The title that the user taps to advance to the next fieldset. Only applies to certain form styles.
 */
@property (nonatomic, strong) NSString *advancementButtonTitle;

/**
 A block to be executed when the user taps the continue button.
 If nil default behaviour is to advance to the next fieldset in the form.
 */
@property (nonatomic, strong) FFKFieldsetAdvancementHandler advancementHandler;
- (void)setAdvancementHandler:(FFKFieldsetAdvancementHandler)advancementHandler;

@property (readonly, assign) BOOL inputsContainValidatorErrors;

/**
 Creates a new instance of a fieldset, with a configuration handler to set properties
 */
+ (instancetype)fieldsetWithConfigurationHandler:(FFKFieldsetConfigurationHandler)configurationHandler;


@end
