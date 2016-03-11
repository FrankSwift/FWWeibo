//
//  FWBaseParam.h
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWBaseParam : NSObject
/** 用于调用access_token，接口获取授权后的access token。 */
@property (nonatomic, copy) NSString *access_token;


+ (instancetype)param;
@end
