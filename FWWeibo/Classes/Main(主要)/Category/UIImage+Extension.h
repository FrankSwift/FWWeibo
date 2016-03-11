//
//  UIImage+Extension.h
//  FWWeibo
//
//  Created by travelzen on 16/1/29.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  图片拉伸
 */
+ (UIImage *)resizeImage:(NSString *)name;

/**
 *  图片变圆角
 */

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius;


- (UIImage *)yal_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius;
@end
