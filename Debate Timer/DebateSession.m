//
//  DebateSession.m
//  Debate Timer
//
//  Created by Chen Zhibo on 7/18/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "DebateSession.h"

@implementation DebateSession

- (NSMutableArray *)reminds
{
    if (!_reminds) {
        _reminds = [NSMutableArray array];
    }
    return _reminds;
}


@end
