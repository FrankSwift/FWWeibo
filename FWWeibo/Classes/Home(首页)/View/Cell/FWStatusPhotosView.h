//
//  FWStatusPhotosView.h
//  FWWeibo
//
//  Created by travelzen on 16/2/22.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWStatusPhotosView : UIView

/** 配图数组 */
@property (nonatomic, strong, nullable) NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(NSUInteger)photosCount;
@end
