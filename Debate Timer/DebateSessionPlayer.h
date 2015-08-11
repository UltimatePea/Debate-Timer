//
//  DebateSessionPlayer.h
//  Debate Timer
//
//  Created by Chen Zhibo on 7/19/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DebateSession;

@interface DebateSessionPlayer : NSObject

- (instancetype)initWithDebateSession:(DebateSession *)debateSession;
- (void)playWithUpdateBlock:(void (^)(NSTimeInterval currentTime))block;
- (void)stop;

@end
