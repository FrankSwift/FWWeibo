//
//  FWEmotionToolbar.m
//  FWWeibo
//
//  Created by travelzen on 16/2/23.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionToolbar.h"

@interface FWEmotionToolbar ()
/** 记录当前选中的按钮 */
@property(nonatomic, weak) UIButton *selectedButton;
@end
@implementation FWEmotionToolbar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加工具条
        [self setupToolbar];
        // 监听监听表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:FWEmotionDidSelectedNotification object:nil];
    }
    return self;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  监听表情选中的通知
 */
- (void)emotionDidSelected:(NSNotification *)noti{
    if (self.selectedButton.tag == FWEmotionTypeRecent) {
        [self btnClick:self.selectedButton];
    }

}

/**
 *  添加工具条
 */
- (void)setupToolbar{
    
    [self setupToolbarButton:@"最近" tag:FWEmotionTypeRecent];
    [self setupToolbarButton:@"默认" tag:FWEmotionTypeDefault];
    [self setupToolbarButton:@"Emoji" tag:FWEmotionTypeEmoji];
    [self setupToolbarButton:@"浪小花" tag:FWEmotionTypeLxh];
    
}

- (void)setDelegate:(id<FWEmotionToolbarDelegate>)delegate{
    _delegate = delegate;
    // 默认选中
    UIButton *defaultButton = (UIButton *)[self viewWithTag:FWEmotionTypeDefault];
    [self btnClick:defaultButton];

}

/**
*  添加工具条按钮
*
*  @param title 按钮文字
*/
- (UIButton *)setupToolbarButton:(NSString *)title tag:(FWEmotionType)tag{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:KColor(whiteColor) forState:UIControlStateNormal];
    [btn setTitleColor:KColor(darkGrayColor) forState:UIControlStateSelected];
    btn.titleLabel.font = KFont(13);

    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:btn];

    int count = (int)self.subviews.count;

    if (count == 1) {
    [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    }else if (count == 4){
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }else{
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
        
        return btn;
}

/**
 *  监听按钮的点击
 */
- (void)btnClick:(UIButton *)sender{
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:sender.tag];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.width / 4;
    CGFloat buttonH = self.height;
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = self.subviews[i];
        btn.width = buttonW;
        btn.height = buttonH;
        btn.x = buttonW * i;
        btn.y = 0;
    }
}

@end
