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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _accessoryLabel = [UILabel new];
        self.accessoryLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.accessoryLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.accessoryLabel.frame = CGRectMake(85, 0, self.bounds.size.width - 100, self.bounds.size.height);
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
    // Subclass me
}

- (void)defocus
{
    // Subclass me
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
