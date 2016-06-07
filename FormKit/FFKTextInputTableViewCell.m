//
//  FFKTextInputTableViewCell.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTextInputTableViewCell.h"
#import "FormKit.h"

@implementation FFKTextInputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _textField = [[UITextField alloc] init];
        self.textField.userInteractionEnabled = NO;
        self.textField.textAlignment = NSTextAlignmentRight;
        self.textField.delegate = self;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:self.textField];
        
        [self.textField addTarget:self action:@selector(handleTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return self;
}

- (void)layoutSubviews
{
    if (self.accessoryType == UITableViewCellAccessoryDetailButton) {
        self.textField.frame = CGRectMake(150 - 15 - 30, 0, self.bounds.size.width - 150, self.bounds.size.height);
    } else {
        self.textField.frame = CGRectMake(150 - 15, 0, self.bounds.size.width - 150, self.bounds.size.height);
    }
    
    [super layoutSubviews];
}

- (void)focus
{
    // We disable interaction so the cell captures the interaction instead (then we can focus on the cell, etc)
    self.textField.userInteractionEnabled = YES;
    [self.textField becomeFirstResponder];
}

- (void)defocus
{
    [self.textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textField.userInteractionEnabled = NO;
    self.input.value = textField.text;
}

- (void)handleTextFieldDidChange:(UITextField *)sender
{
    FFKFormatter *formatter = self.input.formatter;
    
    if (formatter) {
        self.textField.text = formatter.formatHandler(formatter, sender.text);
    }
}

@end
