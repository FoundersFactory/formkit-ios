//
//  FFKAutocompleter.h
//  FormKit
//
//  Created by Phillip Caudell on 01/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFKTextInput;

@protocol FFKTextAutocompleterProtocol <NSObject>

/**
 The input associated with the autocompleter.
 */
@property (nonatomic, copy) FFKTextInput *input;

/**
 Overide this method to provide completion results. The method is passed an initial term, which you can then peform whatever logic is required to return results ia the completion block.
 */
- (void)resultsForString:(NSString *)string withCompletion:(void (^)(NSArray *results))completion;

@optional

/**
 An accessory view to be placed in the textfield.
 */
@property (nonatomic, copy) UIView *textFieldAccessoryView;

/**
 Postpones calling resultsForString:completions until the user's typing has finished. Useful if you're performing a network lookup, and want to reduce the number of requests
 */
@property (nonatomic, assign) BOOL deferResultsTillTypingFinished;

@end
