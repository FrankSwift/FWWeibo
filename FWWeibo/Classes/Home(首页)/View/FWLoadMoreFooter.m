//
//  FWLoadMoreFooter.m
//  FWWeibo
//
//  Created by travelzen on 16/2/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWLoadMoreFooter.h"

@interface FWLoadMoreFooter ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;


@end
@implementation FWLoadMoreFooter

+ (instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"FWLoadMoreFooter" owner:nil options:nil] lastObject];
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据...";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉可以加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}

@end
