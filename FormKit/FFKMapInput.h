//
//  FFKMapInput.h
//  FormKit
//
//  Created by Phillip Caudell on 09/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <FormKit/FormKit.h>

@interface FFKMapInput : FFKInput

@property (nonatomic, strong) NSArray *annotations;

+ (instancetype)mapInput;

@end
