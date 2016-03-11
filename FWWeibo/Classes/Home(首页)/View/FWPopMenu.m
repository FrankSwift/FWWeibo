//
//  FWPopMenu.m
//  FWWeibo
//
//  Created by travelzen on 16/2/5.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWPopMenu.h"

@interface FWPopMenu()
/** 内容 */
@property (nonatomic, strong, nullable) UIView *contentView;

/** 遮盖 */
@property (nonatomic, strong, nullable) UIButton *cover;

/** 容器 */
@property (nonatomic, strong, nullable) UIImageView *container;

@end

@implementation FWPopMenu

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.cover = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cover.backgroundColor = KColor(clearColor);
        [self.cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cover];
        
        self.container = [[UIImageView alloc] init];
        self.container.userInteractionEnabled = YES;
        [self addSubview:self.container];

      
        
        self.direction = FWPopMenuArrowDirectionMiddle;
    }
    
    return self;
}
- (instancetype)initWithContentView:(UIView *)contentView block:(void (^)())block{
    if (self = [super init]) {
        self.contentView = contentView;
        self.block = block;
    }
    return self;
}

+ (instancetype)popMenuWithContentView:(UIView *)contentView block:(void (^)())block{
    return [[self alloc] initWithContentView:contentView block:block];
}

/**
 *  点击遮盖
 */
- (void)coverClick:(UIButton *)sender{
    [self dismiss];
}

- (void)setDirection:(FWPopMenuArrowDirection)direction{
    _direction = direction;
    
    switch (direction) {
        case FWPopMenuArrowDirectionLeft:
            self.container.image = [UIImage resizeImage:@"popover_background_left"];
            break;
        case FWPopMenuArrowDirectionRight:
             self.container.image = [UIImage resizeImage:@"popover_background_right"];
            break;
        case FWPopMenuArrowDirectionMiddle:
             self.container.image = [UIImage resizeImage:@"popover_background"];
            break;
        
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

/**
 *  移除遮盖
 */
- (void)dismiss{
    !self.block ?: self.block();
    [self removeFromSuperview];
}

- (void)showInRect:(CGRect)frame{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.frame;
    [window addSubview:self];
    
    self.container.frame = frame;
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}

- (void)setDimBackground:(BOOL)dimBackground{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.cover.backgroundColor = KColor(blackColor);
        self.cover.alpha = 0.5;
    }else{
        self.cover.backgroundColor = KColor(clearColor);
        self.cover.alpha = 1;
    }
}
@end
