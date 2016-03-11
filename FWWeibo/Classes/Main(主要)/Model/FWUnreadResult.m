//
//  FWUnreadResult.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWUnreadResult.h"

@implementation FWUnreadResult

- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}

@end
