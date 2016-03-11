//
//  FWEmotionTextView.m
//  FWWeibo
//
//  Created by travelzen on 16/3/2.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionTextView.h"
#import "FWEmotion.h"
@implementation FWEmotionTextView
- (void)appendEmotion:(FWEmotion *)emotion
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    if (emotion.emoji) {
        NSAttributedString *subStr = [[NSAttributedString alloc] initWithString:emotion.emoji];
        [attributedText appendAttributedString:subStr];
    }else{
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@%@",emotion.finderPath,emotion.png]];
        CGFloat imageW = self.font.lineHeight;
        CGFloat imageH = imageW;
        attach.bounds = CGRectMake(0, -3, imageW, imageH);
        NSAttributedString *subStr = [NSAttributedString attributedStringWithAttachment:attach];
        [attributedText appendAttributedString:subStr];
    }
    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    
    self.attributedText = attributedText;
    
}

- (NSString *)realText
{
//    // 1.用来拼接所有文字
//    NSMutableString *string = [NSMutableString string];
//    
//    // 2.遍历富文本里面的所有内容
//    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
//        HMEmotionAttachment *attach = attrs[@"NSAttachment"];
//        if (attach) { // 如果是带有附件的富文本
//            [string appendString:attach.emotion.chs];
//        } else { // 普通的文本
//            // 截取range范围的普通文本
//            NSString *substr = [self.attributedText attributedSubstringFromRange:range].string;
//            [string appendString:substr];
//        }
//    }];
//    
//    return string;
    
    return nil;
}



@end
