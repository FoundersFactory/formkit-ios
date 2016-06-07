//
//  FKFormViewController.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKFormViewController.h"
#import "FormKit.h"

@interface FFKFormViewController ()

@end

@implementation FFKFormViewController

- (instancetype)initWithForm:(FFKForm *)form
{
    if (self = [super init]) {
        
        _form = form;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.displaysCancelButton) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(handleCancel:)];
    }
}

- (void)willShowKeyboard:(NSNotification *)notification
{
    
}

- (void)willHideKeyboard:(NSNotification *)notification
{
    
}

- (FFKTextInput *)nextFocusableInput
{
    return nil;
}

- (FFKInput *)nextInput
{
    return nil;
}

- (void)focusInput:(FFKInput *)input animated:(BOOL)animated
{
    
}

- (void)handleCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
