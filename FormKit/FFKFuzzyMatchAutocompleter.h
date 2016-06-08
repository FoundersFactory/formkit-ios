//
//  FFKFuzzyMatchAutocompleter.h
//  FormKit
//
//  Created by Phillip Caudell on 08/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <FormKit/FormKit.h>

@interface FFKFuzzyMatchAutocompleter : NSObject <FFKTextAutocompleterProtocol>

@property (nonatomic, copy) FFKTextInput *input;
@property (nonatomic, strong) NSArray *dataset;

+ (instancetype)fuzzyMatchAutocompleterWithDataset:(NSArray *)dataset;

@end
