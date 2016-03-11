//
//  UIBarButtonItem+Extension.h
//  FWWeibo
//
//  Created by travelzen on 16/1/20.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  创建BarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)acion;
@end
