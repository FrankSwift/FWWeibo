//
//  FWStatusCell.h
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWStatusFrame;
@interface FWStatusCell : UITableViewCell

/** 模型Frame */
@property (nonatomic, strong, nullable) FWStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
