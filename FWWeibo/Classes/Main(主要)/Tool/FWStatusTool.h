//
//  FWStatusTool.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  微博业务类:处理跟微博相关的一切业务, 比如加载微博数据,发微博,删微博

#import <Foundation/Foundation.h>

#import "FWHomeStatusParam.h"
#import "FWHomeStatusesResult.h"

#import "FWSendStatusParam.h"
#import "FWSendStatusResult.h"

#import "FWBaseTool.h"

@interface FWStatusTool : FWBaseTool

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)homeStatusWithParam:(FWHomeStatusParam *)param success:(void(^)(FWHomeStatusesResult *result))success failure:(void(^)(NSError* error))failure;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)sendStatus:(FWSendStatusParam *)param success:(void(^)(FWSendStatusResult *result))success failure:(void(^)(NSError* error))failure;

@end
