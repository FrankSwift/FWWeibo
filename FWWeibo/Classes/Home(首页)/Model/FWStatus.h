//
//  FWStatus.h
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWUser;
@interface FWStatus : NSObject


@property (nonatomic, copy, nullable) NSString *source;///< 微博来源

/** 微博作者的用户信息字段 */
@property (nonatomic, strong, nullable) FWUser *user;

/** 微博创建时间 */
@property (nonatomic, copy, nullable) NSString *created_at;

/** 微博ID */
@property (nonatomic, copy, nullable) NSString *idstr;

/** 微博内容 */
@property (nonatomic, copy, nullable) NSString *text;

/** 微博内容 */
@property (nonatomic, copy, nullable) NSAttributedString *attributedText;

/** 被转发的原微博信息字段，当该微博为转发微博时返回  */
@property (nonatomic, strong, nullable) FWStatus *retweeted_status;

/** 转发数 */
@property (nonatomic, assign) int reposts_count;

/** 评论数 */
@property (nonatomic, assign) int comments_count;

/** 表态数 */
@property (nonatomic, assign) int attitudes_count;

/** 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。 */
@property (nonatomic, strong, nullable) NSArray *pic_urls;

@property (nonatomic, assign, getter=isRetweeted) BOOL retweeted; ///<判断是否是转发微博

@property (nonatomic, assign, getter=isDetail) BOOL detail; ///<判断是否显示详情页
@end
