//
//  FWEmotionAttachment.m
//  FWWeibo
//
//  Created by travelzen on 16/3/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionAttachment.h"
#import "FWEmotion.h"

@implementation FWEmotionAttachment

- (void)setEmotion:(FWEmotion *)emotion{
    _emotion = emotion;
    
    self.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@/%@", emotion.finderPath, emotion.png]];
}
@end
