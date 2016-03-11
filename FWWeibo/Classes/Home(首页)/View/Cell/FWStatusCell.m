//
//  FWStatusCell.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusCell.h"
#import "FWStatusDetailView.h"
#import "FWStatusToolBar.h"
#import "FWStatus.h"
#import "FWStatusFrame.h"
#import "FWStatusDetailView.h"


@interface FWStatusCell ()
/** 微博具体内容 */
@property(nonatomic, weak) FWStatusDetailView *detailView;

/** 工具条 */
@property(nonatomic, weak) FWStatusToolBar *toolbar;

@end
@implementation FWStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加微博具体内容
        [self setupDetailView];
        
        // 添加工具条
        [self setupToolbar];
        
    }
    
    return self;
}

/**
 *  添加微博具体内容
 */
- (void)setupDetailView{
    FWStatusDetailView *detailView = [[FWStatusDetailView alloc] init];
    [self.contentView addSubview: detailView];
    self.detailView = detailView;
}

/**
 *  添加工具条
 */
- (void)setupToolbar{
    FWStatusToolBar *toolbar = [[FWStatusToolBar alloc] init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)setStatusFrame:(FWStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    self.toolbar.frame = statusFrame.toolFrame;
    
    
    self.toolbar.status = statusFrame.status;

}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"statusCell";
    FWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[FWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    return cell;
}

@end
