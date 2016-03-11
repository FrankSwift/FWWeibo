//
//  FWStatusDetailView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusDetailView.h"
#import "FWStatusOriginalView.h"
#import "FWStatusRetweetedView.h"
#import "FWStatusDetailFrame.h"
#import "FWStatusOriginalFrame.h"
#import "FWStatusRetweetedFrame.h"

@interface FWStatusDetailView ()
/** 原创微博 */
@property(nonatomic, weak) FWStatusOriginalView *originalView;

/** 转发微博 */
@property(nonatomic, weak) FWStatusRetweetedView *retweetedView;

@end
@implementation FWStatusDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage resizeImage:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizeImage:@"timeline_card_top_background_highlighted"];
        self.userInteractionEnabled = YES;
        // 添加原创微博
        [self setupOriginalView];
        
        // 添加转发微博
        [self setupRetweetedView];
    }
    return self;
}

/**
 *  添加原创微博
 */
- (void)setupOriginalView{
    FWStatusOriginalView *originalView = [[FWStatusOriginalView alloc] init];
    [self addSubview: originalView];
    self.originalView = originalView;
}

/**
 *  添加转发微博
 */
- (void)setupRetweetedView{
    FWStatusRetweetedView *retweetedView = [[FWStatusRetweetedView alloc] init];
    [self addSubview: retweetedView];
    self.retweetedView = retweetedView;
}

- (void)setDetailFrame:(FWStatusDetailFrame *)detailFrame{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}


@end
