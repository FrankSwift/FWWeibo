//
//  FWUser.h
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWUser : NSObject

/** 友好显示名称 */
@property (nonatomic, copy, nullable) NSString *name;

/** 用户头像地址 */
@property (nonatomic, copy, nullable) NSString *profile_image_url;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/** 会员类型 */
@property (nonatomic, assign) int mbtype;

/** 是否是会员 */
@property (nonatomic, assign, getter=isVip, readonly) BOOL vip;
@end
