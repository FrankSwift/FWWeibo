//
//  FWStatusDetailView.h
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  微博的具体内容 = 原创 + 转发

#import <UIKit/UIKit.h>

@class FWStatusDetailFrame;
@interface FWStatusDetailView : UIImageView
@property (nonatomic, strong) FWStatusDetailFrame *detailFrame;
@end
