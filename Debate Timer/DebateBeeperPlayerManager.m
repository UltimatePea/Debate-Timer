//
//  DebateBeeperPlayerManager.m
//  Debate Timer
//
//  Created by Chen Zhibo on 7/21/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "DebateBeeperPlayerManager.h"
#import "DebateBeeperPlayer.h"
@interface DebateBeeperPlayerManager ()

@property (strong, nonatomic) NSMutableArray *debateBeeperPlayers;

@end

@implementation DebateBeeperPlayerManager

- (NSMutableArray *)debateBeeperPlayers
{
    if (!_debateBeeperPlayers) {
        _debateBeeperPlayers = [NSMutableArray array];
    }
    return _debateBeeperPlayers;
}

- (DebateBeeperPlayer *)playForTimes:(int)numberOfTimes;
{
    DebateBeeperPlayer *player = [[DebateBeeperPlayer alloc] initWithTimesPlay:numberOfTimes interval:0.3 compeleteBlock:^{
        [self.debateBeeperPlayers removeObject:player];
    }];
    [self.debateBeeperPlayers addObject:player];
    [player play];
    return player;
}

- (void)stopAll
{
    [self.debateBeeperPlayers enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        [obj stop];
    }];
}

@end
