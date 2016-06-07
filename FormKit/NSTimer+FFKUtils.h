//
//  NSTimer+Prototype.h
//  Prototype
//
//  Created by Phillip Caudell on 19/05/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (FFKUtils)

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end
