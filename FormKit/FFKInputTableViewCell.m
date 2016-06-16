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
        self.textLabel.textColor = self.validationErrorColor;
        self.accessoryType = UITableViewCellAccessoryDetailButton;
        
        CAKeyframeAnimation *animation = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
        animation.values =  @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-10.0f, 0.0f, 0.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(10.0f, 0.0f, 0.0f)]];
        animation.autoreverses = YES;
        animation.repeatCount = 3.0f;
        animation.duration = 0.08f;
        
        [self.layer addAnimation:animation forKey:nil];
        
    } else {
        self.textLabel.textColor = [UIColor blackColor];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)setInput:(FFKInput *)input
{
    [self willChangeValueForKey:@"input"];
    _input = input;
    
    self.textLabel.text = input.titleText;
    self.detailTextLabel.text = input.detailText;
    self.imageView.image = input.image;
    self.accessoryLabel.text = input.accessoryText;
    
    if (input.validatorError) {
        [self setValidatorErrorStyleEnabled:YES];
    } else {
        [self setValidatorErrorStyleEnabled:NO];
    }
    
    if (input.isCheckable) {
        if ([input.value isEqualToNumber:@(1)]) {
            [self check];
        } else {
            [self uncheck];
        }
    }
    
    [self willChangeValueForKey:@"input"];
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
