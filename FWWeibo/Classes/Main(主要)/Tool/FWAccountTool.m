//
//  FWAccountTool.m
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#define FWAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]

#import "FWAccountTool.h"
#import "FWAccount.h"

@implementation FWAccountTool

+ (void)save:(FWAccount *)account{

    //归档
    [NSKeyedArchiver archiveRootObject:account toFile:FWAccountFilepath];
}

+ (FWAccount *)account{
    //解档
    FWAccount *account =  [NSKeyedUnarchiver unarchiveObjectWithFile:FWAccountFilepath];
    
    // 判断账号是否已经过期
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expires_time] != NSOrderedAscending) {//过期
        account = nil;
    }
    
    return account;
    
}

+ (void)accessTokenWithParam:(FWAccessTokenParam *)param success:(void (^)(FWAccount *))success failure:(void (^)(NSError *))failure{
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[FWAccount class] success:success failure:failure];
}
@end
