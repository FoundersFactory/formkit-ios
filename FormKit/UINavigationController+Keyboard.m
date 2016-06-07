//
//  UINavigationController+FFKUtils.m
//  FormKit
//
//  Created by Phillip Caudell on 03/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "UINavigationController+Keyboard.h"
#import <objc/runtime.h>
#import "FormKit.h"

@implementation UINavigationController (Keyboard)

- (void)startAdjustingFrameToKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)handleKeyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, keyboardFrame.origin.y);
    
    FFKFormViewController *viewController = (FFKFormViewController *)self.topViewController;
    
    if ([viewController respondsToSelector:@selector(willShowKeyboard:)]) {
        [viewController willShowKeyboard:notification];
    }
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, keyboardFrame.origin.y);
    
    FFKFormViewController *viewController = (FFKFormViewController *)self.topViewController;
    
    if ([viewController respondsToSelector:@selector(willShowKeyboard:)]) {
        [viewController willHideKeyboard:notification];
    }
}

@end
