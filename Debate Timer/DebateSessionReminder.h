//
//  DebateSessionReminders.h
//  Debate Timer
//
//  Created by Chen Zhibo on 7/18/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DebateSessionReminder : NSObject
@property (nonatomic) int beepTimes;//0 indicates constant beeping
@property (nonatomic) float magnitude;//from 0 to 1
@property (nonatomic) NSTimeInterval timePoint;
- (instancetype)initWithBeepTimes:(int)beepTimes timePoint:(NSTimeInterval)timePoint;
+ (instancetype)reminder;

@end
