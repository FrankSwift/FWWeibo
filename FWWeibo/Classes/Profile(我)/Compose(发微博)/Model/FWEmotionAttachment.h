//
//  FWEmotionAttachment.h
//  FWWeibo
//
//  Created by travelzen on 16/3/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWEmotion;
@interface FWEmotionAttachment : NSTextAttachment
@property (nonatomic, strong) FWEmotion *emotion;
@end
