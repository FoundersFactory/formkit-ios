//
//  FFKBarButtonItem.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKBarButtonItem.h"

@implementation FFKBarButtonItem

- (void)startActivityAnimating
{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicatorView startAnimating];
    self.customView = self.activityIndicatorView;
}

- (void)stopActivityAnimating
{
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView = nil;
    self.customView = nil;
}

@end
