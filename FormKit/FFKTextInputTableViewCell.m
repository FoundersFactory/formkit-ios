//
//  FFKTextInputTableViewCell.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTextInputTableViewCell.h"
#import "FormKit.h"

@interface FFKTextInputTableViewCell ()

@property (nonatomic, strong) NSTimer *typingTimer;
@property (nonatomic, assign) BOOL isTimerDirty;

@end

@implementation FFKTextInputTableViewCell

@dynamic input;

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
    CGFloat offsetX = 150;

    if (!self.textLabel.text) {
        offsetX = 30;
        self.textField.textAlignment = NSTextAlignmentLeft;
    } else {
        self.textField.textAlignment = NSTextAlignmentRight;
    }
    
    if (self.accessoryType == UITableViewCellAccessoryDetailButton) {
        self.textField.frame = CGRectMake(offsetX - 15 - 30, 0, self.bounds.size.width - offsetX, self.bounds.size.height);
    } else {
        self.textField.frame = CGRectMake(offsetX - 15, 0, self.bounds.size.width - offsetX, self.bounds.size.height);
    }
    
    [super layoutSubviews];
}

- (void)setInput:(FFKTextInput *)input
{
    [super setInput:input];
    
    self.textField.placeholder = input.placeholderText;
    self.textField.text = input.value;
    self.textField.keyboardType = input.keyboardType;
    self.textField.autocorrectionType = input.autocorrectionType;
    self.textField.autocapitalizationType = input.autocapitalizationType;
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
    self.textField.userInteractionEnabled = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self defocus];
}

- (void)handleTextFieldDidChange:(UITextField *)sender
{
    FFKTextInput *textInput = (FFKTextInput *)self.input;
    FFKFormatter *formatter = textInput.formatter;
    FFKTextAutocompleter *textAutocompleter = textInput.textAutocompleter;

    self.input.value = sender.text;
    self.input.suggestion = NO;
    
    if (formatter) {
        sender.text = formatter.formatHandler(formatter, sender.text);
    }
    
    if (textAutocompleter) {
        
        if (textAutocompleter.deferCompletingUntillTypingHasFinished) {
            
            if (self.isTimerDirty && !self.typingTimer) {
                self.typingTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(handleTypingTimer:) userInfo:nil repeats:NO];
            }
            
            self.isTimerDirty = YES;
            
            
        } else {
            textAutocompleter.string = sender.text;
            
        }
    }
}

- (void)handleTypingTimer:(NSTimer *)sender
{
    self.typingTimer = nil;
    self.isTimerDirty = NO;

    FFKTextInput *textInput = (FFKTextInput *)self.input;
    FFKTextAutocompleter *textAutocompleter = textInput.textAutocompleter;
    textAutocompleter.string = self.textField.text;
}

@end
