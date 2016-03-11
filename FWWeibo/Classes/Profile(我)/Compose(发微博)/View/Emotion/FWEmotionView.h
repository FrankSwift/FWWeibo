//
//  FWEmotionView.h
//  FWWeibo
//
//  Created by travelzen on 16/2/29.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWEmotion;
@interface FWEmotionView : UIButton

/** 表情模型 */
@property (nonatomic, strong, nullable) FWEmotion *emotion;
@end
