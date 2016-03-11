//
//  FWAccountTool.h
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWBaseTool.h"
#include "FWAccessTokenParam.h"
@class FWAccount;
@interface FWAccountTool : FWBaseTool

/**
 *  存储账号
 */
+ (void)save:(FWAccount *)account;

/**
 *  读取账号
 */
+ (FWAccount *)account;

/**
 *  获取accessToken
 *
 *  @param param   请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)accessTokenWithParam:(FWAccessTokenParam *)param success:(void(^)(FWAccount *result))success failure:(void(^)(NSError* error))failure;

@end
