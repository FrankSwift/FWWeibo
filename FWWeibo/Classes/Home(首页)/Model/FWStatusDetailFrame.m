//
//  FWStatusDetailFrame.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusDetailFrame.h"
#import "FWStatusOriginalFrame.h"
#import "FWStatusRetweetedFrame.h"
#import "FWStatus.h"

@implementation FWStatusDetailFrame

- (void)setStatus:(FWStatus *)status {
    _status = status;
    
     // 1.计算原创微博的frame
    FWStatusOriginalFrame *originalFrame = [[FWStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    _originalFrame = originalFrame;
    
    // 2.计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        FWStatusRetweetedFrame *retweetedFrame = [[FWStatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        _retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = HMStatusCellMargin;
    CGFloat w = KScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
    
    
}
@end
