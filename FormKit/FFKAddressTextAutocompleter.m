//
//  FFKAddressTextAutocompleter.m
//  FormKit
//
//  Created by Phillip Caudell on 09/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKAddressTextAutocompleter.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "FormKit.h"

@implementation FFKAddressTextAutocompleter

- (instancetype)init
{
    if (self = [super init]) {
        
        self.deferCompletingUntillTypingHasFinished = YES;
    }
    
    return self;
}

+ (instancetype)addressTextAutocompleterWithRegionString:(NSString *)regionString;
{
    FFKAddressTextAutocompleter *autocompleter = [FFKAddressTextAutocompleter new];
    autocompleter.regionString = regionString;
    
    return autocompleter;
}

- (void)setString:(NSString *)string
{
    MKLocalSearchRequest *searchRequest = [MKLocalSearchRequest new];
    
    if (self.regionString) {
        searchRequest.naturalLanguageQuery = [string stringByAppendingFormat:@" %@", self.regionString];
    } else {
        searchRequest.naturalLanguageQuery = string;
    }
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        
        NSArray *inputs = [response.mapItems mapObjectsUsingBlock:^id(MKMapItem *mapItem, NSInteger idx) {
            return [FFKInput inputWithConfigurationHandler:^(FFKInput *input) {
                
                CLPlacemark *placemark = mapItem.placemark;
                NSString *addressString = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
                
                input.titleText = mapItem.name;
                input.detailText = [[addressString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@\n",mapItem.name] withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@", "];
                input.value = addressString;
                input.context = mapItem;
            }];
        }];
        
        self.results = inputs;
    }];
}

- (FFKInput *)additionalInputForSelectedInput:(FFKMapInput *)selectedInput
{
    FFKMapInput *mapInput = [FFKMapInput new];
    mapInput.annotations = @[selectedInput.context];
    
    return mapInput;
}

@end
