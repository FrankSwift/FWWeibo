//
//  FWBaseTool.m
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWBaseTool.h"
#import "FWHttpTool.h"
#import "MJExtension.h"


@implementation FWBaseTool

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FWHttpTool get:url params:[param mj_keyValues] success:^(id responseObj) {
        id result = [resultClass mj_objectWithKeyValues:responseObj];
        !success ?: success(result);
    } failure:^(NSError *error) {
        !failure ?: failure(error);
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [FWHttpTool post:url params:[param mj_keyValues] success:^(id responseObj) {
        id result = [resultClass mj_objectWithKeyValues:responseObj];
        !success ?: success(result);
    } failure:^(NSError *error) {
        !failure ?: failure(error);
    }];
}
@end
