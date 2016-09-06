//
//  FFKImageTableViewCell.m
//  FormKit
//
//  Created by Founders Factory on 05/09/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKImageTableViewCell.h"
#import "FFKInput.h"


@implementation FFKImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.seperatorsHidden = YES;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image) {
        CGFloat margin = 20.f;
        CGSize imageSize = CGSizeMake(self.imageView.image.size.width, self.imageView.image.size.height);
        CGRect finalFrame = CGRectMake(CGRectGetMidX(self.contentView.frame) - (imageSize.width / 2.0) + margin, margin, imageSize.width - (2.0 * margin), imageSize.height - (2.0 * margin));
        self.imageView.frame = finalFrame;
    }
}

@synthesize input = _input;

- (void)setInput:(FFKInput *)input
{
    [self willChangeValueForKey:@"input"];
    _input = input;
    
    self.imageView.image = input.image;
    [self setNeedsLayout];
    
    [self didChangeValueForKey:@"input"];
}

@end
