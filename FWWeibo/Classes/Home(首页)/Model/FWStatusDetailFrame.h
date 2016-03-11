//
//  FWStatusDetailFrame.h
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWStatusOriginalFrame;
@class FWStatusRetweetedFrame;
@class FWStatus;
@interface FWStatusDetailFrame : NSObject

@property (nonatomic, strong, nullable,readonly) FWStatusOriginalFrame *originalFrame;
@property (nonatomic, strong, nullable,readonly) FWStatusRetweetedFrame *retweetedFrame;

/** 数据模型 */
@property (nonatomic, strong, nullable) FWStatus *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;
@end
