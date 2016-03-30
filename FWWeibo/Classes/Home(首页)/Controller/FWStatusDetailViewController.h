//
//  FWStatusDetailViewController.h
//  FWWeibo
//
//  Created by 沈方伟 on 16/3/20.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWStatus;
@interface FWStatusDetailViewController : UITableViewController
@property (nonatomic, strong) FWStatus *status;
@end
