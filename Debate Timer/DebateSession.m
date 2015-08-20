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

#define KEY_REMINDS @"KEY_REMINDS"
#define KEY_LENGTH @"KEY_LENGTH"

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [aCoder encodeObject:self.reminds forKey:KEY_REMINDS];
    [aCoder encodeDouble:self.length forKey:KEY_LENGTH];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.reminds = [aDecoder decodeObjectForKey:KEY_REMINDS];
        self.length = [aDecoder decodeDoubleForKey:KEY_LENGTH];
    }
    return self;
}

@end
