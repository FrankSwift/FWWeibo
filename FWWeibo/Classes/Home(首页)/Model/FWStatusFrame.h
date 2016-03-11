//
//  FWStatusFrame.h
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWStatus;
@class FWStatusDetailFrame;
@interface FWStatusFrame : NSObject

/** 数据模型 */
@property (nonatomic, strong, nullable) FWStatus *status;


@property (nonatomic, strong, nullable,readonly) FWStatusDetailFrame *detailFrame;
@property (nonatomic, assign, readonly) CGRect toolFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
