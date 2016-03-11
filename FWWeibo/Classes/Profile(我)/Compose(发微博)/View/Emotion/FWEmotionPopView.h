//
//  FWEmotionPopView.h
//  FWWeibo
//
//  Created by travelzen on 16/3/2.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWEmotionView;
@interface FWEmotionPopView : UIView

+ (instancetype)popView;

- (void)dismiss;
- (void)showFromEmotionView:(FWEmotionView *)fromEmotionView;
@end
