//
//  FormKit.h
//  FormKit
//
//  Created by Phillip Caudell on 07/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for FormKit.
FOUNDATION_EXPORT double FormKitVersionNumber;

//! Project version string for FormKit.
FOUNDATION_EXPORT const unsigned char FormKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FormKit/PublicHeader.h>

#import <FormKit/FFKForm.h>
#import <FormKit/FFKFieldset.h>
#import <FormKit/FFKInput.h>
#import <FormKit/FFKTextInput.h>
#import <FormKit/FFKValidator.h>
#import <FormKit/FFKValidatorError.h>
#import <FormKit/FFKFormatter.h>
#import <FormKit/FFKFormViewController.h>
#import <FormKit/FFKPagedFormViewController.h>
#import <FormKit/FFKBarButtonItem.h>
#import <FormKit/FFKInputTableViewCell.h>
#import <FormKit/FFKTextInputTableViewCell.h>
#import <FormKit/NSTimer+FFKUtils.h>
#import <FormKit/UINavigationController+Keyboard.h>
#import <FormKit/FFKFeatureTableViewCell.h>

static NSString * const FFKFormKitErrorDomain = @"com.foundersfactory.formkit";
