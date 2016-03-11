//
//  FWUserTool.m
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWUserTool.h"
#import "FWHttpTool.h"
#import "MJExtension.h"

@implementation FWUserTool

+ (void)userInfoWithParam:(FWUserInfoParam *)param success:(void (^)(FWUserInfoResult *))success failure:(void (^)(NSError *))failure{

    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[FWUserInfoResult class] success:success failure:failure];
}

+ (void)unreadWithParam:(FWUnreadParam *)param success:(void (^)(FWUnreadResult *))success failure:(void (^)(NSError *))failure{
    [self getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[FWUnreadResult class] success:success failure:failure];
}
@end
