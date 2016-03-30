//
//  FWStatusLabel.m
//  FWWeibo
//
//  Created by 沈方伟 on 16/3/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusLabel.h"
#import "FWLink.h"

#define FWLinkBackgroundTag 10000
@interface FWStatusLabel ()
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong, nullable) NSMutableArray *links; ///<FWLinkArray
@end
@implementation FWStatusLabel

/**
 1. 查找出所有的链接(用一个数组存放所有的链接)
 2. 在touchesBegan方法中, 根据触摸点找出被点击的链接
 3. 在touchesEnded或则touchesCancel方法中, 移除所有的链接背景
 */

- (NSMutableArray *)links{
    if (!_links) {
        NSMutableArray *links = [NSMutableArray array];
        
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            NSString *linkText = attrs[HMLinkText];
            if (linkText == nil) {
                return ;
            }
            
            FWLink *link = [[FWLink alloc] init];
            link.text = linkText;
            link.range = range;
            
            
            // 处理矩形框
            NSMutableArray *rects = [NSMutableArray array];
            // 设置选中的字符范围
            self.textView.selectedRange = range;
            // 算出选中的字符范围的边框
            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) {
                    continue;
                }
                [rects addObject:selectionRect];
            }
            link.rects = rects;
            
            [links addObject:link];
        }];
        self.links = links;
    }
    
    return _links;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UITextView *textView = [[UITextView alloc] init];
        
        textView.editable = NO;
        
        textView.scrollEnabled = NO;
        
        textView.userInteractionEnabled = NO;
        // 设置文字的内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 5);
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        
        self.textView = textView;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}

#pragma mark - 公共接口
- (void)setAttributedText:(NSAttributedString *)attributedText{
    
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
    
    self.links = nil;
}
#pragma mark - 事件处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    FWLog(@"%@",NSStringFromCGPoint(point));
    // 得出被点击的那个链接
    FWLink *touchLink = [self touchLinkWithPoint:point];
    
    // 设置链接有选中的背景
    [self showLinkBackground:touchLink];
   
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    FWLinkDidSelectedNotificaion
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    // 得出被点击的那个链接
    FWLink *touchLink = [self touchLinkWithPoint:point];
    if (touchLink) {
        // 说明手指在摸个链接上面抬起来, 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:FWLinkDidSelectedNotificaion object:nil userInfo:@{HMLinkText : touchLink.text}];
    }
    
    // 相当于触摸被取消
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackgound];
        
    });}
#pragma mark - 链接背景处理
/**
 *  根据触摸点找出被触摸的链接
 *
 *  @param point 触摸点
 */
- (FWLink *)touchLinkWithPoint:(CGPoint)point{
    __block FWLink *touchLink = nil;
    [self.links enumerateObjectsUsingBlock:^(FWLink *link, NSUInteger idx, BOOL * _Nonnull stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchLink = link;
                break;
                
            }
        }
    }];
    
    return touchLink;
}

/**
 *  显示链接的背景
 *
 *  @param link 需要显示背景的link
 */
- (void)showLinkBackground:(FWLink *)link{
    for (UITextSelectionRect *selectionRect in link.rects) {
        UIView *bg = [[UIView alloc] init];
        bg.tag = FWLinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.backgroundColor = [UIColor redColor];
        bg.frame = selectionRect.rect;
        [self insertSubview:bg atIndex:0];
    }
}

- (void)removeAllLinkBackgound{
    for (UIView *child in self.subviews) {
        if (child.tag == FWLinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  这个方法会返回能够处理事件的控件
 *  这个方法可以用来拦截所有触摸事件
 *  @param point 触摸点
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self touchLinkWithPoint:point]) {
        return self;
    }
    return nil;
}

@end
