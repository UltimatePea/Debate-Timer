//
//  DebateSessionPlayer.m
//  Debate Timer
//
//  Created by Chen Zhibo on 7/19/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "DebateSessionPlayer.h"
#import "DebateSessionReminderPlayerEntry.h"
#import "DebateBeeperPlayerManager.h"
#import "DebateSession.h"
#import "DebateSessionReminder.h"

@interface DebateSessionPlayer ()

@property (strong, nonatomic) DebateSession *debateSession;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) void (^block)(NSTimeInterval currentTime);
@property (strong, nonatomic) NSDate *startingTime;
@property (nonatomic) NSTimeInterval currentTime;
@property (strong, nonatomic) DebateBeeperPlayerManager *player;
@property (strong, nonatomic) NSMutableArray *debateSessionReminderEntries;
@end

@implementation DebateSessionPlayer



- (instancetype)initWithDebateSession:(DebateSession *)debateSession
{
    self = [super init];
    if (self) {
        self.debateSession = debateSession;
        self.debateSessionReminderEntries = [NSMutableArray array];
        [debateSession.reminds enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
            [self.debateSessionReminderEntries addObject:[[DebateSessionReminderPlayerEntry alloc] initWithReminder:obj]];
        }];
        self.currentTime = 0;
    }
    return self;
}
- (NSTimeInterval)currentTime
{
    return _currentTime;
}

- (void)playWithUpdateBlock:(void (^)(NSTimeInterval currentTime))block
{
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    self.block = block;
    self.startingTime = [NSDate dateWithTimeIntervalSinceNow:0.0];
    self.currentTime = 0;
    [self.timer fire];
}

- (void)timer:(NSTimer *)timer
{
    self.currentTime += 0.1;
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    if ([currentDate timeIntervalSinceDate:self.startingTime] - self.currentTime >= 0.1) {
        NSLog(@"Timer Probably Error");
    }
    self.block(self.currentTime);
    [self playAccordingToCurrentTime:self.currentTime];
    
    
}

- (void)playAccordingToCurrentTime:(NSTimeInterval)currentTime
{
    [self.debateSessionReminderEntries enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        DebateSessionReminderPlayerEntry *entry = obj;
        if (entry.reminder.timePoint<=currentTime&&entry.hasPlayed==NO) {
            [self.player playForTimes:entry.reminder.beepTimes];
            entry.hasPlayed = YES;
            
        }
    }];
}

- (void)stop
{
    [self.timer invalidate];
    [self.player stopAll];
    self.currentTime = 0;
    self.startingTime = nil;
}
@end
