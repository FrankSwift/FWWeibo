//
//  FWHttpTool.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  网络请求工具类,负责整个项目所有的Http请求

#import <Foundation/Foundation.h>

@interface FWHttpTool : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params photoParams:(NSDictionary *)photoParams constructingBodyWithBlock:(void(^)(id formData))constructing success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
@end
