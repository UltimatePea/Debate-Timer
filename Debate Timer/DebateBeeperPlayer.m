//
//  DebateBeeper.m
//  Debate Timer
//
//  Created by Chen Zhibo on 7/19/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//
#import "DebateBeeperPlayer.h"
@import AVFoundation;
@interface DebateBeeperPlayer ()

@property (nonatomic, readwrite) int times, interval;
@property (strong, nonatomic) AVPlayer *player;
@property (nonatomic) int currentTimes;
@property (strong, nonatomic) void (^completeBlock)();
@end

@implementation DebateBeeperPlayer


- (instancetype)initWithTimesPlay:(int)times interval:(int)interval compeleteBlock:(void (^)())completeBlock;
{
    self = [self init];
    if (self) {
        self.times = times;
        self.interval = interval;
        self.shouldStop = false;
        self.completeBlock = completeBlock;
    }
    return self;
}

- (void)play
{
    self.player = [[AVPlayer alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"Glass" withExtension:@"aiff"]];
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];
    
    [self.player play];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    self.currentTimes++;
    if (self.currentTimes<self.times && !self.shouldStop) {
        AVPlayerItem *p = [notification object];
        [p seekToTime:kCMTimeZero];
    } else {
        self.completeBlock();
    }
    
}
- (void)stop
{
    self.shouldStop = YES;
}

- (void)setShouldStop:(BOOL)shouldStop
{
    _shouldStop = shouldStop;
    if (shouldStop) {
        [self.player pause];
        self.player = nil;
    }
}


@end
