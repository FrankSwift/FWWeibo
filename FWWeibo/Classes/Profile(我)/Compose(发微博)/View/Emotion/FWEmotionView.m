//
//  FWEmotionView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/29.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionView.h"
#import "FWEmotion.h"
#import "NSString+Emoji.h"

@implementation FWEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(FWEmotion *)emotion{
    _emotion = emotion;

    if (emotion.coder) {
        [UIView setAnimationsEnabled:NO];
        self.titleLabel.font = KFont(34);
        [self setTitle:[NSString emojiWithStringCode:[emotion coder]] forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:YES];
        });
    }else{
        NSString *imgPath = [NSString stringWithFormat:@"%@%@",[emotion finderPath],[emotion png]];
        UIImage *image = [UIImage imageWithName:imgPath];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
