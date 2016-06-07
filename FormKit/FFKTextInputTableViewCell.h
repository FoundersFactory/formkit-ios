//
//  FFKTextInputTableViewCell.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKInputTableViewCell.h"

@interface FFKTextInputTableViewCell : FFKInputTableViewCell <UITextFieldDelegate>

@property (readonly, strong) UITextField *textField;

@end
