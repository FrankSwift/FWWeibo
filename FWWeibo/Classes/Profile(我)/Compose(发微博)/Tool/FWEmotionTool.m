//
//  FWEmotionTool.m
//  FWWeibo
//
//  Created by travelzen on 16/2/23.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionTool.h"
#import "MJExtension.h"
#import "FWEmotion.h"


#define FWRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]

@implementation FWEmotionTool
/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;

/** 最近表情 */
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/default.plist" ofType:nil];
        
        _defaultEmotions = [FWEmotion mj_objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setFinderPath:) withObject:@"EmotionIcons/default/"];
    }
    
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/emoji.plist" ofType:nil];
        _emojiEmotions = [FWEmotion mj_objectArrayWithFile:plist];
        
        [_emojiEmotions makeObjectsPerformSelector:@selector(setFinderPath:) withObject:@"EmotionIcons/emoji/"];
    }
    
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/lxh.plist" ofType:nil];
        _lxhEmotions = [FWEmotion mj_objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setFinderPath:) withObject:@"EmotionIcons/lxh/"];
    }
    
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions
{
    if (!_recentEmotions) {
        // 去沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:FWRecentFilepath];
        FWLog(@"%@",FWRecentFilepath);
        if (!_recentEmotions) { // 沙盒中没有任何数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}



// Emotion -- 戴口罩 -- Emoji的plist里面加载的表情
+ (void)addRecentEmotion:(FWEmotion *)emotion
{
    // 加载最近的表情数据
    [self recentEmotions];
    
    // 删除之前的表情
    [_recentEmotions removeObject:emotion];
    
    // 添加最新的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 存储到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:FWRecentFilepath];
}
//
//+ (HMEmotion *)emotionWithDesc:(NSString *)desc
//{
//    if (!desc) return nil;
//    
//    __block HMEmotion *foundEmotion = nil;
//    
//    // 从默认表情中找
//    [[self defaultEmotions] enumerateObjectsUsingBlock:^(HMEmotion *emotion, NSUInteger idx, BOOL *stop) {
//        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
//            foundEmotion = emotion;
//            *stop = YES;
//        }
//    }];
//    if (foundEmotion) return foundEmotion;
//    
//    // 从浪小花表情中查找
//    [[self lxhEmotions] enumerateObjectsUsingBlock:^(HMEmotion *emotion, NSUInteger idx, BOOL *stop) {
//        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
//            foundEmotion = emotion;
//            *stop = YES;
//        }
//    }];
//    
//    return foundEmotion;
//}

@end
