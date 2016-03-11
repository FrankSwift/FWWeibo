//
//  FWStatusRetweetedFrame.h
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWStatus;
@interface FWStatusRetweetedFrame : NSObject
/** 原创微博模型 */
@property (nonatomic, strong, nullable) FWStatus *retweetedStatus;


/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 配图相册  */
@property (nonatomic, assign) CGRect photosFrame;
/** 工具条  */
@property (nonatomic, assign) CGRect toolbarFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

@end
