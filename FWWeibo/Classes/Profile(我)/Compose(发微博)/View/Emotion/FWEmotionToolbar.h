//
//  FWEmotionToolbar.h
//  FWWeibo
//
//  Created by travelzen on 16/2/23.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWEmotionToolbar;

typedef enum {
    FWEmotionTypeRecent, // 最近
    FWEmotionTypeDefault, // 默认
    FWEmotionTypeEmoji, // Emoji
    FWEmotionTypeLxh // 浪小花
} FWEmotionType;

@protocol FWEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(FWEmotionToolbar *)toolbar didSelectedButton:(FWEmotionType)emotionType;
@end

@interface FWEmotionToolbar : UIView
 /** 回调 */
@property(nonatomic, assign) id<FWEmotionToolbarDelegate> delegate;
@end
