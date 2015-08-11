//
//  DebateSessionReminderPlayerEntry.m
//  Debate Timer
//
//  Created by Chen Zhibo on 7/21/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "DebateSessionReminderPlayerEntry.h"
@class DebateSessionReminder;
@implementation DebateSessionReminderPlayerEntry
- (instancetype)initWithReminder:(DebateSessionReminder *)reminder;
{
    self = [super init];
    if (self) {
         self.reminder = reminder;
        self.hasPlayed = NO;
    }
   
    return self;
}
@end
