//
//  FFKValidatorError.h
//  FormKit
//
//  Created by Phillip Caudell on 06/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFKInput;

@interface FFKValidatorError : NSError

@property (nonatomic, weak) FFKInput *input;

+ (instancetype)validatorErrorWithInput:(FFKInput *)input localizedDescription:(NSString *)localisedDescription recoverySuggestion:(NSString *)recoverySuggestion;

@end
