//
//  FFKInputTableViewCell.m
//  FormKit
//
//  Created by Phillip Caudell on 03/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKInputTableViewCell.h"
#import "FormKit.h" 

@implementation FFKInputTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setValidatorErrorStyleEnabled:(BOOL)enabled
{
    if (enabled) {
        self.textLabel.textColor = [UIColor redColor];
        self.accessoryType = UITableViewCellAccessoryDetailButton;
    } else {
        self.textLabel.textColor = [UIColor blackColor];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)focus
{
    
}

- (void)defocus
{
    
}

- (void)check
{
    self.accessoryType = UITableViewCellAccessoryCheckmark;
    self.input.value = @(1);
}

- (void)uncheck
{
    self.accessoryType = UITableViewCellAccessoryNone;
    self.input.value = nil;
}

@end
