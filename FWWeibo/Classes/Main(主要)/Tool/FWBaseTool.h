//
//  FWBaseTool.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  最基本的业务工具类

#import <Foundation/Foundation.h>

@interface FWBaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id result))success failure:(void(^)(NSError* error))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id result))success failure:(void(^)(NSError* error))failure;
@end
