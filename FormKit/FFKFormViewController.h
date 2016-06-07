//
//  FKFormViewController.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFKForm;
@class FFKInput;

@interface FFKFormViewController : UIViewController

@property (readonly, strong) FFKForm *form;
@property (nonatomic, assign) BOOL displaysCancelButton;

- (instancetype)initWithForm:(FFKForm *)form;

- (void)focusInput:(FFKInput *)input animated:(BOOL)animated;
- (FFKInput *)nextInput;
- (FFKInput *)nextFocusableInput;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end
