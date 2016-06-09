//
//  FFKFuzzyMatchTextAutocompleter.m
//  FormKit
//
//  Created by Phillip Caudell on 08/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKFuzzyMatchTextAutocompleter.h"
#import <TableKit/TableKit.h>
#import <FormKit/FormKit.h>

@implementation FFKFuzzyMatchTextAutocompleter

+ (instancetype)autocompleterWithStrings:(NSArray<NSString *> *)strings
{
    FFKFuzzyMatchTextAutocompleter *autocompleter = [FFKFuzzyMatchTextAutocompleter new];
    autocompleter.strings = strings;
    
    return autocompleter;
}

- (void)setString:(NSString *)string
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", string];
    NSArray *filteredStrings = [self.strings filteredArrayUsingPredicate:predicate];
    
    NSArray *inputs = [filteredStrings mapObjectsUsingBlock:^id(id object, NSInteger idx) {
        return [FFKInput inputWithConfigurationHandler:^(FFKInput *input) {
            input.titleText = object;
            input.detailText = @"London";
            input.value = object;
        }];
    }];
    
    self.results = inputs;
}

@end
