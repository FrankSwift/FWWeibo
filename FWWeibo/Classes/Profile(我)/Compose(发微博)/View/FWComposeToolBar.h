//
//  FWComposeToolBar.h
//  FWWeibo
//
//  Created by travelzen on 16/2/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWComposeToolBar;

typedef enum {
    FWComposeToolbarButtonTypeCamera, // 照相机
    FWComposeToolbarButtonTypePicture, // 相册
    FWComposeToolbarButtonTypeMention, // 提到@
    FWComposeToolbarButtonTypeTrend, // 话题
    FWComposeToolbarButtonTypeEmotion // 表情
} FWComposeToolbarButtonType;

typedef void(^FWComposeToolBarBlock)(FWComposeToolBar * toolBar,FWComposeToolbarButtonType type);
@interface FWComposeToolBar : UITextView

/** 回调相关 */
@property (nonatomic, copy) FWComposeToolBarBlock block;

- (instancetype)initWithButtonClick:(FWComposeToolBarBlock) block;

/**
 *  设置某个按钮的图片
 *
 *  @param image 图片名
 *  @param type  按钮类型
 */
//- (void)setButtonImage:(NSString *)image buttonType:(FWComposeToolbarButtonType)type;

/** 是否要显示表情按钮 */
@property (nonatomic, assign, getter=isShowEmotionButton) BOOL showEmotionButton;
@end
