//
//  FWEmotionGridView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/24.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionGridView.h"
#import "FWEmotion.h"
#import "FWEmotionView.h"
#import "FWEmotionPopView.h"
#import "FWEmotionTool.h"

@interface FWEmotionGridView ()

/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

/** emotion数组 */
@property (nonatomic, strong) NSMutableArray *emotionArray;

/** 放大镜 */
@property (nonatomic, strong, nullable) FWEmotionPopView *popView;
@end
@implementation FWEmotionGridView

- (FWEmotionPopView *)popView{
    if (!_popView) {
        _popView = [FWEmotionPopView popView];
    }
    
    return _popView;
}
- (NSMutableArray *)emotionArray{
    if (!_emotionArray) {
        self.emotionArray = [NSMutableArray array];
    }
    return _emotionArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.deleteButton = [[UIButton alloc] init];
        [self.deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [self.deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        self.deleteButton.hidden = NO;
        [self.deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteButton];
        
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

/**
 *  根据触摸点返回对应的表情控件
 */
- (FWEmotionView *)emotionWithPoint:(CGPoint)point{
    __block FWEmotionView *foundEmotionView = nil;
    
    [self.emotionArray enumerateObjectsUsingBlock:^(FWEmotionView *emotionView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(emotionView.frame, point)) {
            foundEmotionView = emotionView;
            //停止遍历
            *stop = YES;
        }
    }];
    
    return foundEmotionView;
}

/**
 *  长按手势
 */
- (void)longPress:(UILongPressGestureRecognizer *)recognizer{
    //1.捕获触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    //2.检测触摸点落在哪个表情上
    FWEmotionView *emotionView = [self emotionWithPoint:point];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {//手松开
        [self.popView dismiss];
        
        //选中表情
        [self selectedEmotion:emotionView.emotion];
        
    }else{
        [self.popView showFromEmotionView:emotionView];
    }
   
}
- (void)setEmotions:(NSArray *)emotions{
    [self.popView removeFromSuperview];
    _emotions = emotions;
    
    int count = (int)self.emotions.count;
    
    int currentEmotionViewCount = (int)self.emotionArray.count;
    for (int i = 0; i < count; i ++) {
        FWEmotionView *btn = nil;
        
        if (i >= currentEmotionViewCount) {
            btn = [[FWEmotionView alloc] init];
            [self addSubview:btn];
            [self.emotionArray addObject:btn];
            
        }else{
            btn = self.emotionArray[i];
        }
        [btn addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.emotion = emotions[i];
        btn.hidden = NO;
    }
    
    // 隐藏多余的emotionView
    for (int i = count; i<currentEmotionViewCount; i++) {
        FWEmotionView *emotionView = (FWEmotionView *)self.emotionArray[i];
        emotionView.hidden = YES;
    }
    
}

/**
 *  点击了表情
 */
- (void)emotionClick:(FWEmotionView *)sender{
    [self.popView showFromEmotionView:sender];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
        [self selectedEmotion:sender.emotion];
    });
    
   
}

/**
 *  点击了删除按钮
 */
- (void)deleteClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:FWEmotionDidDeleteNotification object:nil userInfo:nil];
}

/**
 *  选中表情
 */
- (void)selectedEmotion:(FWEmotion *)emotion{
    if (!emotion) return;
    //保存记录
    [FWEmotionTool addRecentEmotion:emotion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FWEmotionDidSelectedNotification object:nil userInfo:@{FWSelectedEmotion : emotion}];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    int count = (int)self.emotionArray.count;
    CGFloat leftMargin = 10;
    CGFloat btnWH = ( KScreenWidth - 2 * leftMargin) / FWEmotionMaxCols;
    CGFloat topMargin = self.height - FWEmotionMaxRows * btnWH;
    
    for (int i = 0; i < count; i ++) {
        FWEmotionView *btn = (FWEmotionView *)self.emotionArray[i];
        btn.x = leftMargin + btnWH * (i % FWEmotionMaxCols);
        btn.y = topMargin + btnWH * (i / FWEmotionMaxCols);
        btn.width = btnWH;
        btn.height = btnWH;
    }
    
    //删除按钮的frame
    self.deleteButton.x = leftMargin + btnWH * (FWEmotionMaxCols - 1) ;
    self.deleteButton.y = topMargin + btnWH * (FWEmotionMaxRows - 1) ;
    self.deleteButton.width = btnWH ;
    self.deleteButton.height = btnWH;
    self.deleteButton.hidden = NO;

}
@end
