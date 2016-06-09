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

@implementation FFKAddressTextAutocompleter

- (instancetype)init
{
    if (self = [super init]) {
        
        self.deferCompletingUntillTypingHasFinished = YES;
    }
    
    return self;
}

- (void)setString:(NSString *)string
{
    MKLocalSearchRequest *searchRequest = [MKLocalSearchRequest new];
    searchRequest.naturalLanguageQuery = string;
    searchRequest.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(51.515313, -0.126323), MKCoordinateSpanMake(0.1, 0.1));
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        
        NSArray *inputs = [response.mapItems mapObjectsUsingBlock:^id(MKMapItem *mapItem, NSInteger idx) {
            return [FFKInput inputWithConfigurationHandler:^(FFKInput *input) {
                
                CLPlacemark *placemark = mapItem.placemark;
                NSString *addressString = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
                
                input.titleText = mapItem.name;
                input.detailText = [[addressString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@\n",mapItem.name] withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@", "];
                input.value = addressString;
            }];
        }];
        
        self.results = inputs;
    }];

    /*
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
     */
}

@end
