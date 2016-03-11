//
//  UIImage+Extension.m
//  FWWeibo
//
//  Created by travelzen on 16/1/29.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithName:(NSString *)name{
    UIImage *image = nil;
    if (IOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    
    return image;
}

+ (UIImage *)resizeImage:(NSString *)name{
    UIImage *image = [UIImage imageWithName:name];
//    return [image resizableImageWithCapInsets:<#(UIEdgeInsets)#> resizingMode:UIImageResizingModeStretch];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius{
//    CGRect frame = CGRectMake(0, 0, self.size.width, self.size.height);
//    
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
//    
//    [[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius] addClip];
//    
//    [self drawInRect:frame];
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return image;
    
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
    
}

- (UIImage *)yal_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}
@end
