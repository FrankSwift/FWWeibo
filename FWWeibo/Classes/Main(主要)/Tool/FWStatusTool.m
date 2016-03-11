//
//  FWStatusTool.m
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusTool.h"
//#import "FWHttpTool.h"
//#import "MJExtension.h"



@implementation FWStatusTool
+(void)homeStatusWithParam:(FWHomeStatusParam *)param success:(void (^)(FWHomeStatusesResult *))success failure:(void (^)(NSError *))failure{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param resultClass:[FWHomeStatusesResult class] success:success failure:failure];
}

+(void)sendStatus:(FWSendStatusParam *)param success:(void (^)(FWSendStatusResult *))success failure:(void (^)(NSError *))failure{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:[FWSendStatusResult class] success:success failure:failure];
}
@end
