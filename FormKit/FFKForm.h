//
//  FFKForm.h
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFKFieldset;
@class FFKInput;
@class FFKForm;

@protocol FFKFormDelegate <NSObject>

- (void)form:(FFKForm *)form willPresentFieldset:(NSArray <FFKFieldset *> *)fieldsets;

@end

@interface FFKForm : NSObject

/**
 The name of the form. Useful for referencing if you're managing multiple forms.
 */
@property (nonatomic, strong) NSString *name;

/**
 The fieldsets belonging to the form.
 */
@property (nonatomic, strong) NSArray <FFKFieldset *> *fieldsets;

@property (nonatomic, weak) id <FFKFormDelegate> delegate;

- (NSArray <FFKInput *> *)inputsForName:(NSString *)name;
- (FFKInput *)firstInputForName:(NSString *)name;
- (NSDictionary *)valuesDictionary;
- (NSDictionary *)valuesForFieldset:(FFKFieldset *)fieldset;

@end
