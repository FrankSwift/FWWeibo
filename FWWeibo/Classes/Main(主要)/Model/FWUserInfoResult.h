//
//  FWUserInfoResult.h
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWUserInfoResult : NSObject

/** 友好显示名称 */
@property (nonatomic, copy, nullable) NSString *name;
/** 用户头像地址 */
@property (nonatomic, copy, nullable) NSString *profile_image_url;

@end
