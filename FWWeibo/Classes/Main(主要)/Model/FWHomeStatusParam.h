//
//  FWHomeStatusParam.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  封装加载首页微博数据的请求参数

#import <Foundation/Foundation.h>

@interface FWHomeStatusParam : NSObject
/** 用于调用access_token，接口获取授权后的access token。 */
@property (nonatomic, copy) NSString *access_token;

/** 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。 */
@property (nonatomic, copy) NSString *since_id;

/** 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。 */
@property (nonatomic, copy) NSString *max_id;

/** 单页返回的记录条数，最大不超过100，默认为20。 */
@property (nonatomic, copy) NSString *count;
@end
