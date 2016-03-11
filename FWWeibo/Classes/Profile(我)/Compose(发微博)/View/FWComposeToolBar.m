//
//  FWComposeToolBar.m
//  FWWeibo
//
//  Created by travelzen on 16/2/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWComposeToolBar.h"

@interface FWComposeToolBar()
/** 照相机 */
@property(nonatomic, weak) UIButton *camerabutton;
/** 图片 */
@property(nonatomic, weak) UIButton *picture;
/** 艾特 */
@property(nonatomic, weak) UIButton *mentionbutton;
/** 话题 */
@property(nonatomic, weak) UIButton *trendbutton;
/** emoji */
@property(nonatomic, weak) UIButton *emotionButton;

@end

@implementation FWComposeToolBar

- (instancetype)initWithButtonClick:(FWComposeToolBarBlock)block{
    if (self = [super init]) {
        _block = block;
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        // 添加所有的子控件
        self.camerabutton = [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:FWComposeToolbarButtonTypeCamera];
        self.picture = [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:FWComposeToolbarButtonTypePicture];
        self.mentionbutton = [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:FWComposeToolbarButtonTypeMention];
        self.trendbutton = [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:FWComposeToolbarButtonTypeTrend];
        self.emotionButton = [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:FWComposeToolbarButtonTypeEmotion];
    }
    return self;
}

/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(FWComposeToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    !self.block?:self.block(self,button.tag);
}


- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
//    _showEmotionButton = showEmotionButton;
    if (showEmotionButton) { // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else { // 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            count ++;
        }
    }
    
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    
    int n = 0;
    for (int i = 0; i < self.subviews.count; i ++) {
        UIView *button = self.subviews[i];
        if (![button isKindOfClass:[UIButton class]]) continue;
        button.y = 0;
        button.width = buttonW;
        button.height = buttonH;
        button.x = n * buttonW;
        n++;
    }

}
@end
