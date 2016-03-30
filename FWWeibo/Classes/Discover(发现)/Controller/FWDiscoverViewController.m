//
//  FWDiscoverViewController.m
//  FWWeibo
//
//  Created by 沈方伟 on 16/1/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWDiscoverViewController.h"
#import "FWSearchBar.h"
#import "FWCommonGroup.h"
#import "FWCommonItem.h"
#import "FWCommonCell.h"


@interface FWDiscoverViewController ()
@property (nonatomic, strong, nullable) NSMutableArray *groups;
@end

@implementation FWDiscoverViewController

- (NSMutableArray *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}
/**
 *  屏蔽tableview的样式
 */
- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    FWSearchBar *searchBar = [FWSearchBar searchBar];
    searchBar.width = KScreenWidth - 20;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
    // 初始化模型数据
    [self setupGroups];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  初始化模型数据
 */
- (void)setupGroups{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];

}

- (void)setupGroup0
{
    // 1.创建组
    FWCommonGroup *group = [FWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
//    HMCommonArrowItem *hotStatus = [HMCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
//    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
//    hotStatus.destVcClass = [HMOneViewController class];
//    
//    HMCommonArrowItem *findPeople = [HMCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
//    findPeople.badgeValue = @"N";
//    findPeople.destVcClass = [HMOneViewController class];
//    findPeople.subtitle = @"名人、有意思的人尽在这里";
//    
//    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    FWCommonGroup *group = [FWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
//    FWCommonItem *gameCenter = [FWCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
//    gameCenter.destVcClass = [HMTwoViewController class];
//    
//    HMCommonLabelItem *near = [HMCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
//    near.destVcClass = [HMTwoViewController class];
//    near.text = @"测试文字";
//    
//    HMCommonSwitchItem *app = [HMCommonSwitchItem itemWithTitle:@"应用" icon:@"app"];
//    app.destVcClass = [HMTwoViewController class];
//    app.badgeValue = @"10";
//    
//    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    FWCommonGroup *group = [FWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
//    HMCommonSwitchItem *video = [HMCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
//    video.operation = ^{
//        HMLog(@"----点击了视频---");
//    };
//    
//    HMCommonSwitchItem *music = [HMCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
//    HMCommonItem *movie = [HMCommonItem itemWithTitle:@"电影" icon:@"movie"];
//    movie.operation = ^{
//        HMLog(@"----点击了电影");
//    };
//    HMCommonLabelItem *cast = [HMCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
//    cast.operation = ^{
//        HMLog(@"----点击了播客");
//    };
//    cast.badgeValue = @"5";
//    cast.subtitle = @"(10)";
//    cast.text = @"axxxx";
//    HMCommonArrowItem *more = [HMCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
//    //    more.badgeValue = @"998";
//    
//    group.items = @[video, music, movie, cast, more];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FWCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FWCommonCell *cell = [FWCommonCell cellWithTableView:tableView];
    FWCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}
@end
