//
//  MKMapItem+Annotation.m
//  FormKit
//
//  Created by Phillip Caudell on 09/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "MKMapItem+Annotation.h"

@implementation MKMapItem (Annotation)

- (NSString *)title
{
    return self.name;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.placemark.location.coordinate;
}

@end
