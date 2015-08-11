//
//  DebateBeeper.h
//  Debate Timer
//
//  Created by Chen Zhibo on 7/19/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DebateBeeperPlayer : NSObject

- (instancetype)initWithTimesPlay:(int)times interval:(int)interval compeleteBlock:(void (^)())completeBlock;
@property (nonatomic, readonly) int times, interval;
- (void)play;
- (void)stop;
@property (nonatomic) BOOL shouldStop;
@end
