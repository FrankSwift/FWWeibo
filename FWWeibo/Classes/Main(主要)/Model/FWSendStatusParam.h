//
//  FWSendStatusParam.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWSendStatusParam : NSObject

/** 用于调用access_token，接口获取授权后的access token。 */
@property (nonatomic, copy) NSString *access_token;

/** 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字 */
@property (nonatomic, copy) NSString *status;

@end
