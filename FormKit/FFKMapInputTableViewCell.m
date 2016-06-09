//
//  FFKMapInputTableViewCell.m
//  FormKit
//
//  Created by Phillip Caudell on 09/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKMapInputTableViewCell.h"
#import <FormKit/FormKit.h>
#import <MapKit/MapKit.h>
#import "MKMapItem+Annotation.h"    

@implementation FFKMapInputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _mapView = [[MKMapView alloc] init];
        [self.contentView addSubview:self.mapView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mapView.frame = self.contentView.bounds;
}

- (void)setInput:(FFKMapInput *)input
{
    [super setInput:input];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:input.annotations];
    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
    
}

@end
