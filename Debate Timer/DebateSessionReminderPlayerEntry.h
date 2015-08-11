//
//  DebateSessionReminderPlayerEntry.h
//  Debate Timer
//
//  Created by Chen Zhibo on 7/21/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DebateSessionReminder;
@interface DebateSessionReminderPlayerEntry : NSObject


@property (strong, nonatomic) DebateSessionReminder *reminder;
@property (nonatomic) BOOL hasPlayed;
- (instancetype)initWithReminder:(DebateSessionReminder *)reminder;

@end
