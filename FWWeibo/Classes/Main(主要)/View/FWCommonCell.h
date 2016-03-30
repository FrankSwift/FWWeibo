//
//  FWCommonCell.h
//  FWWeibo
//
//  Created by 沈方伟 on 16/3/20.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWCommonItem;
@interface FWCommonCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic, strong) FWCommonItem *item;
@end
