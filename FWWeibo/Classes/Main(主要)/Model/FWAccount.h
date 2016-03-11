//
//  FWAccount.h
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWAccount : NSObject<NSCoding>

/** 用于调用access_token，接口获取授权后的access token。 */
@property (nonatomic, copy) NSString *access_token;

/** access_token的生命周期，单位是秒数。 */
@property (nonatomic, copy) NSString *expires_in;

/** 当前授权用户的UID。 */
@property (nonatomic, copy) NSString *uid;

/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;

/** 用户昵称 */
@property (nonatomic, copy) NSString *screen_name;


@end
