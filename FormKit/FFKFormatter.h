//
//  FFKFormatter.h
//  FormKit
//
//  Created by Phillip Caudell on 06/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFKFormatter : NSObject

typedef id (^FFKFormatterHandler)(FFKFormatter *formatter, id original);

@property (nonatomic, strong) FFKFormatterHandler formatHandler;
@property (nonatomic, strong) id formatter;

+ (instancetype)formatterWithConfigurationHandler:(void(^)(FFKFormatter *formatter))configurationHandler formatHandler:(FFKFormatterHandler)formatHandler;
+ (instancetype)stringNumberFormatterWithStyle:(NSNumberFormatterStyle)style;

@end
