//
//  FWStatusFrame.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusFrame.h"

#import "FWStatus.h"
#import "FWStatusDetailFrame.h"

@implementation FWStatusFrame

- (void)setStatus:(FWStatus *)status{
    _status = status;
    
    
    //1. 计算微博具体内容
    [self setupDetailFrame];
    //2. 计算底部工具条
    [self setupToolbarFrame];
    //3. 计算cell的高度
    self.cellHeight = CGRectGetMaxY(_toolFrame);
}

/**
 *  计算微博具体内容
 */
- (void)setupDetailFrame{
    FWStatusDetailFrame *detailFrame = [[FWStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    _detailFrame = detailFrame;
}

/**
 *  计算底部工具条
 */
- (void)setupToolbarFrame{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = KScreenWidth;
    CGFloat toolbarH = 35;
    _toolFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);

}
@end
