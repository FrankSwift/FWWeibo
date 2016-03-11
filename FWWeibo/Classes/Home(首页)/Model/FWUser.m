//
//  FWUser.m
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWUser.h"

@implementation FWUser

- (BOOL)isVip{
    // 是会员
    return self.mbtype > 2;
}
@end
