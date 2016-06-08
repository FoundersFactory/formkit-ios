//
//  FFKFuzzyMatchAutocompleter.m
//  FormKit
//
//  Created by Phillip Caudell on 08/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKFuzzyMatchAutocompleter.h"

@implementation FFKFuzzyMatchAutocompleter

+ (instancetype)fuzzyMatchAutocompleterWithDataset:(NSArray *)dataset
{
    FFKFuzzyMatchAutocompleter *autocompleter = [FFKFuzzyMatchAutocompleter new];
    autocompleter.dataset = dataset;
    
    return autocompleter;
}

- (void)resultsForString:(NSString *)string withCompletion:(void (^)(NSArray *))completion
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",string];
    NSArray *filteredDataset = [self.dataset filteredArrayUsingPredicate:predicate];
    
    NSArray *rows = [filteredDataset mapObjectsUsingBlock:^id(id object, NSInteger idx) {
        return [FFKTableRow tableRowWithConfigurationHandler:^(FFKTableRow *row) {
            
            row.text = object;
            row.detailText = @"London";
            row.height = 60;
        }];
    }];
    
    completion(rows);
}

- (BOOL)deferResultsTillTypingFinished
{
    return NO;
}

- (UIView *)textFieldAccessoryView
{
    return nil;
}

@end
