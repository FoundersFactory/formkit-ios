//
//  FFKStaticImageInput.m
//  FormKit
//
//  Created by Founders Factory on 05/09/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKStaticImageInput.h"
#import "FFKImageTableViewCell.h"


@implementation FFKStaticImageInput

+ (instancetype)inputWithConfigurationHandler:(void (^)(FFKInput *))handler
{
    FFKStaticImageInput *input = [[FFKStaticImageInput alloc] init];
    input.focusable = YES;
    handler(input);
    
    return input;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.viewCellClass = [FFKImageTableViewCell class];
    }
    
    return self;
}

@end
