//
//  FWEmotionTextView.h
//  FWWeibo
//
//  Created by travelzen on 16/3/2.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWTextView.h"
@class FWEmotion;
@interface FWEmotionTextView : FWTextView

/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(FWEmotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;

@end
