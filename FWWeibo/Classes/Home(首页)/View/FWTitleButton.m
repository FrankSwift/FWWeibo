//
//  FWTitleButton.m
//  FWWeibo
//
//  Created by travelzen on 16/2/5.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWTitleButton.h"

@implementation FWTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:KColor(blackColor) forState:UIControlStateNormal];
        self.titleLabel.font = KHomeTitleFont;
        self.adjustsImageWhenHighlighted = NO;
    }

    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width - self.height;
    CGFloat titleH = self.height;

    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = 0;
    CGFloat imageH = self.height;
    CGFloat imageW = imageH;
    CGFloat imageX = self.width - imageW;
    
    return CGRectMake(imageX, imageY, imageW, imageH);

}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];

    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : KHomeTitleFont}];
    
    self.width = titleSize.width + self.height + 10;
}
@end
