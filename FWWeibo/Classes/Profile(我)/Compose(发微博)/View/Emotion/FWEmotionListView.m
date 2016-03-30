
//
//  FWEmotionListView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/23.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotionListView.h"
#import "FWEmotionGridView.h"


@interface FWEmotionListView ()<UIScrollViewDelegate>

/** 显示所有表情 */
@property(nonatomic, weak) UIScrollView *scrollView;

/** 显示页码 */
@property(nonatomic, weak) UIPageControl *pageControl;
@end
@implementation FWEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 显示所有表情的scrollView
        [self setupScrollView];
        
        // 2. 显示页码的pageController
        [self setupPageControl];
    }
    return self;
}

/**
 *  显示所有表情的scrollView
 */
- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
}

/**
 *  显示页码的pageController
 */
- (void)setupPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.hidesForSinglePage = YES;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
    [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //1. UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //2. UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    //3. 设置UIScrollView内部空间的尺寸
    int count = (int)self.pageControl.numberOfPages;
    for (int i = 0; i < count; i++) {
        UIView *gridView = self.scrollView.subviews[i];
        gridView.width = self.scrollView.width;
        gridView.height = self.scrollView.height;
        gridView.x = gridView.width * i;
        gridView.y = 0;
    }
    self.scrollView.contentSize = CGSizeMake(count * self.width, 0);
    
}

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    // 设置总页数
    int totalPages = (int)(emotions.count + FWEmotionMaxCountPerPage - 1) / FWEmotionMaxCountPerPage;
    int currentViewNumber = (int)self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.hidden = totalPages <= 1;
    self.pageControl.currentPage = 0;
    
    // 决定scrollView显示多少页表情
    for (int i = 0; i < totalPages; i ++) {
        FWEmotionGridView *gridView = nil;
        
        if (i >= currentViewNumber) {
            gridView = [[FWEmotionGridView alloc] init];
            [self.scrollView addSubview:gridView];
        }else{
            gridView = self.scrollView.subviews[i];
        }
        
        int loc = i * FWEmotionMaxCountPerPage;
        int len = FWEmotionMaxCountPerPage;
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = emotions.count - loc;
        }
        
        gridView.emotions = [emotions subarrayWithRange:NSMakeRange(loc, len)];
        gridView.hidden = NO;
    }
    
    // 隐藏后面的不需要用到的gridView
    for (int i = totalPages; i<currentViewNumber; i++) {
        FWEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    self.scrollView.contentOffset = CGPointZero;
    [self setNeedsLayout];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage =  scrollView.contentOffset.x / scrollView.width + 0.5;
}
@end
