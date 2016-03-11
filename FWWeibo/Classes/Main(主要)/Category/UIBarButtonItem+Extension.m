//
//  UIBarButtonItem+Extension.m
//  FWWeibo
//
//  Created by travelzen on 16/1/20.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barButtonItemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)acion{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:acion forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
@end
