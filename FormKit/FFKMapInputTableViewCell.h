//
//  FFKMapInputTableViewCell.h
//  FormKit
//
//  Created by Phillip Caudell on 09/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <FormKit/FormKit.h>
#import "FFKInputTableViewCell.h"

@class MKMapView;

@interface FFKMapInputTableViewCell : FFKInputTableViewCell

@property (nonatomic, strong) MKMapView *mapView;

@end
