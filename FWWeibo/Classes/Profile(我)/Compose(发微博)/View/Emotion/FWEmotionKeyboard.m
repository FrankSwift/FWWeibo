//
//  FWEmotionKeyboard.m
//  FWWeibo
//
//  Created by travelzen on 16/2/23.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionKeyboard.h"
#import "FWEmotionListView.h"
#import "FWEmotionToolbar.h"
#import "MJExtension.h"
#import "FWEmotion.h"
#import "FWEmotionTool.h"

@interface FWEmotionKeyboard ()<FWEmotionToolbarDelegate>

/** 表情列表 */
@property(nonatomic, weak) FWEmotionListView *listView;

/** 工具条 */
@property(nonatomic, weak) FWEmotionToolbar *toolbar;

@end
@implementation FWEmotionKeyboard


+ (instancetype)keyboard{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 添加表情列表
        [self setupListView];
        // 添加工具条
        [self setupToolbar];
    }
    return self;
}

/**
 *  添加表情列表
 */
- (void)setupListView{
    FWEmotionListView *listView = [[FWEmotionListView alloc] init];
    [self addSubview:listView];
    self.listView = listView;
}


/**
 *  添加工具条
 */
- (void)setupToolbar{
    FWEmotionToolbar *toolbar = [[FWEmotionToolbar alloc] init];
    toolbar.delegate = self;
    [self addSubview:toolbar];
    self.toolbar = toolbar;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.设置toolbar的frame
    self.toolbar.x = 0;
    self.toolbar.width = self.width;
    self.toolbar.height = 35;
    self.toolbar.y = self.height - self.toolbar.height;
    
    // 2.设置listView的frame
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.height - self.toolbar.height;
    
}

#pragma mark - FWEmotionToolbarDelegate
- (void)emotionToolbar:(FWEmotionToolbar *)toolbar didSelectedButton:(FWEmotionType)emotionType{
    switch (emotionType) {
        case FWEmotionTypeDefault:// 默认
            self.listView.emotions = [FWEmotionTool defaultEmotions];
            break;
            
        case FWEmotionTypeEmoji: // Emoji
            self.listView.emotions = [FWEmotionTool  emojiEmotions];
            break;
            
        case FWEmotionTypeLxh: // 浪小花
            self.listView.emotions = [FWEmotionTool lxhEmotions];
            break;
            
        case FWEmotionTypeRecent: // 最近
            self.listView.emotions = [FWEmotionTool recentEmotions];
            break;
    }
}


@end
