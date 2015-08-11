//
//  DebateBeeperPlayerManager.h
//  Debate Timer
//
//  Created by Chen Zhibo on 7/21/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DebateBeeperPlayer;
@interface DebateBeeperPlayerManager : NSObject

- (DebateBeeperPlayer *)playForTimes:(int)numberOfTimes;
- (void)stopAll;
@end
