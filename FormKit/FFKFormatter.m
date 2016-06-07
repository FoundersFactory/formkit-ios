//
//  FFKFormatter.m
//  FormKit
//
//  Created by Phillip Caudell on 06/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKFormatter.h"

@implementation FFKFormatter

+ (instancetype)formatterWithConfigurationHandler:(void (^)(FFKFormatter *))configurationHandler formatHandler:(FFKFormatterHandler)formatHandler
{
    FFKFormatter *formatter = [FFKFormatter new];
    configurationHandler(formatter);
    formatter.formatHandler = formatHandler;
    
    return formatter;
}

+ (instancetype)stringNumberFormatterWithStyle:(NSNumberFormatterStyle)style
{
    return [FFKFormatter formatterWithConfigurationHandler:^(FFKFormatter *formatter) {
        NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
        numberFormatter.numberStyle = style;
        formatter.formatter = numberFormatter;
    } formatHandler:^id(FFKFormatter *formatter, NSString *original) {
        
        original = [original stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSNumberFormatter *numberFormatter = formatter.formatter;
        
        if ([original integerValue] == 0) {
            return nil;
        } else {
            return [numberFormatter stringFromNumber:@([original integerValue])];
        }
    }];
}

@end
