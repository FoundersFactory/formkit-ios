//
//  FFKFuzzyMatchTextAutocompleter.h
//  FormKit
//
//  Created by Phillip Caudell on 08/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTextAutocompleter.h"

@interface FFKFuzzyMatchTextAutocompleter : FFKTextAutocompleter

@property (nonatomic, strong) NSArray <NSString *> *strings;

+ (instancetype)autocompleterWithStrings:(NSArray <NSString *> *)strings;

@end
