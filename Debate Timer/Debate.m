//
//  Debate.m
//  Debate Timer
//
//  Created by Chen Zhibo on 8/19/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "Debate.h"

@implementation Debate

- (NSMutableArray<DebateSession *> *)debateSessions
{
    if (!_debateSessions) {
        _debateSessions = [NSMutableArray array];
    }
    return _debateSessions;
}
#define KEY_DEBATE_SESSIONS @"KEY_DEBATE_SESSIONS"

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [aCoder encodeObject:self.debateSessions forKey:KEY_DEBATE_SESSIONS];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.debateSessions = [aDecoder decodeObjectForKey:KEY_DEBATE_SESSIONS];
    }
    return self;
}
@end
