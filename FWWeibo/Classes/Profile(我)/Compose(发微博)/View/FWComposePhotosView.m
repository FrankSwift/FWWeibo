//
//  FWComposePhotosView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWComposePhotosView.h"

@interface FWComposePhotosView ()

@end
@implementation FWComposePhotosView

- (void)addImage:(UIImage *)image{
    UIImageView *iv = [[UIImageView alloc] init];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = YES;
    iv.image = image;
    [self addSubview:iv];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    int maxColsPerRow = 4;
    CGFloat margin = 10;
    CGFloat imageWH = (self.width - (maxColsPerRow + 1) * margin)/ maxColsPerRow;
    
    for (int i = 0;  i < count; i ++) {
        int row = i / maxColsPerRow;
        int col = i % maxColsPerRow;
        
        UIImageView *iv = self.subviews[i];
        iv.width = imageWH;
        iv.height = imageWH;
        iv.x = col * (imageWH + margin);
        iv.y = row * (imageWH + margin);
    }
}

- (NSArray *)images{
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    
    for (UIView *view  in self.subviews){
        if (![view isKindOfClass:[UIImageView class]]) continue;
        UIImageView *iv = (UIImageView *)view;
        [images addObject:iv.image];
    }
    
    return images;
    
}
@end
