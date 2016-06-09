//
//  FFKMapInput.m
//  FormKit
//
//  Created by Phillip Caudell on 09/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKMapInput.h"
#import "FFKMapInputTableViewCell.h"

@implementation FFKMapInput

- (instancetype)init
{
    if (self = [super init]) {
        self.viewCellClass = [FFKMapInputTableViewCell class];
    }
    
    return self;
}
@end
