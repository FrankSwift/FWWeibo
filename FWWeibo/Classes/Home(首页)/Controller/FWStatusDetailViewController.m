//
//  FWStatusDetailViewController.m
//  FWWeibo
//
//  Created by 沈方伟 on 16/3/20.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusDetailViewController.h"
#import "FWStatusDetailView.h"
#import "FWStatusDetailFrame.h"

@implementation FWStatusDetailViewControllerx1

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"微博正文";
    self.tableView.backgroundColor = FWColor(211, 211, 211, 1.0);
    
    // 设置header
    FWStatusDetailFrame *detailFrame = [[FWStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    
    FWStatusDetailView *dv = [[FWStatusDetailView alloc] init];
    dv.detailFrame = detailFrame;
    
    self.tableView.tableHeaderView = dv;

}

- (void)setStatus:(FWStatus *)status{
    _status = status;
}
@end
