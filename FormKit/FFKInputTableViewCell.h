//
//  FFKInputTableViewCell.h
//  FormKit
//
//  Created by Phillip Caudell on 03/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <TableKit/TableKit.h>

@class FFKTableInteraction;
@class FFKInput;
@class FFKValidatorError;

@interface FFKInputTableViewCell : FFKSubtitleTableViewCell

@property (nonatomic, strong) FFKInput *input;
@property (readonly, strong) UILabel *accessoryLabel;

- (void)focus;
- (void)defocus;
- (void)check;
- (void)uncheck;
- (void)setValidatorErrorStyleEnabled:(BOOL)enabled;

@end
