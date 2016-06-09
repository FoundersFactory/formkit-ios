//
//  FFTextAutocompleter.m
//  FormKit
//
//  Created by Phillip Caudell on 08/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKTextAutocompleter.h"

@implementation FFKTextAutocompleter

- (void)setResults:(NSArray<FFKInput *> *)results
{
    [super willChangeValueForKey:@"results"];
    _results = results;
    
    if (self.resultsHandler) {
        self.resultsHandler(self, results);
    }
    
    [super didChangeValueForKey:@"results"];
}

- (FFKInput *)additionalInputForSelectedInput:(FFKInput *)selectedInput
{
    return nil;
}

@end
