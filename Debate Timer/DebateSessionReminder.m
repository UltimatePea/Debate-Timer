//
//  DebateSessionReminders.m
//  Debate Timer
//
//  Created by Chen Zhibo on 7/18/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "DebateSessionReminder.h"

@implementation DebateSessionReminder

#define KEY_BEEP_TIMES @"KEY_BEEP_TIMES"
#define KEY_MAGNITUDE @"KEY_MAGNITUDE"
#define KEY_TIME_POINT @"KEY_TIME_POINT"

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [aCoder encodeInt:self.beepTimes forKey:KEY_BEEP_TIMES];
    [aCoder encodeFloat:self.magnitude forKey:KEY_MAGNITUDE];
    [aCoder encodeDouble:self.timePoint forKey:KEY_TIME_POINT];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.beepTimes = [aDecoder decodeIntForKey:KEY_BEEP_TIMES];
        self.magnitude = [aDecoder decodeFloatForKey:KEY_MAGNITUDE];
        self.timePoint = [aDecoder decodeDoubleForKey:KEY_TIME_POINT];
    }
    return self;
}

- (instancetype)initWithBeepTimes:(int)beepTimes timePoint:(NSTimeInterval)timePoint;
{
    self = [super init];
    if (self) {
        self.beepTimes = beepTimes;
        self.timePoint = timePoint;
    }
    return self;
}

@end
