//
//  FWEmotionPopView.m
//  FWWeibo
//
//  Created by travelzen on 16/3/2.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionPopView.h"
#import "FWEmotionView.h"

@interface FWEmotionPopView ()
@property (weak, nonatomic) IBOutlet FWEmotionView *emotionView;

@end
@implementation FWEmotionPopView

+ (instancetype)popView{
    return [[[NSBundle mainBundle] loadNibNamed:@"FWEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)drawRect:(CGRect)rect{
    [[UIImage imageWithName:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}

- (void)showFromEmotionView:(FWEmotionView *)fromEmotionView{
    if (!fromEmotionView) return;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
    
    self.emotionView.emotion = fromEmotionView.emotion;
}

- (void)dismiss{
    [self removeFromSuperview];
}
@end
