//
//  FFKBarButtonItem.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFKBarButtonItem : UIBarButtonItem

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

- (void)startActivityAnimating;
- (void)stopActivityAnimating;

@end
