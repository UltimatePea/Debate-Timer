//
//  DebateSession.h
//  Debate Timer
//
//  Created by Chen Zhibo on 7/18/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebateSession : NSObject

@property (nonatomic) NSTimeInterval length;
@property (strong, nonatomic) NSMutableArray *reminds;

@end
