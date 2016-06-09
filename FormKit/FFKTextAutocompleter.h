//
//  FFTextAutocompleter.h
//  FormKit
//
//  Created by Phillip Caudell on 08/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFKInput;

@interface FFKTextAutocompleter : NSObject

/**
 Postpones calling completeString:withCompletion until the user's typing has finished. Useful if you're performing a network lookup, and want to reduce the number of requests
 */
@property (nonatomic, assign) BOOL deferCompletingUntillTypingHasFinished;

/**
 The string to complete on.
 */
@property (nonatomic, strong) NSString *string;

/**
 The suggested inputs.
 */
@property (nonatomic, strong) NSArray <FFKInput *> *results;

/**
 Handler called as suggestions become available.
 */
@property (nonatomic, strong) void (^resultsHandler)(FFKTextAutocompleter *autocompleter, NSArray <FFKInput *> * suggestedInputs);

/**
 Provide an additional input once a user has made a selection from the suggestions.
 */
- (FFKInput *)additionalInputForSelectedInput:(FFKInput *)selectedInput;

@end
