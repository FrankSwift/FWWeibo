//
//  FWUserTool.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWUserInfoParam.h"
#import "FWUserInfoResult.h"
#import "FWBaseTool.h"

#import "FWUnreadParam.h"
#import "FWUnreadResult.h"

@interface FWUserTool : FWBaseTool
/**
 *  加载用户信息
 *
 *  @param param   请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)userInfoWithParam:(FWUserInfoParam *)param success:(void(^)(FWUserInfoResult *result))success failure:(void(^)(NSError* error))failure;

/**
 *  获取某个用户的各种消息未读数
 *
 *  @param param   请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)unreadWithParam:(FWUnreadParam *)param success:(void(^)(FWUnreadResult *result))success failure:(void(^)(NSError* error))failure;
@end
