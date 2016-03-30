//
//  FWHomeViewController.m
//  FWWeibo
//
//  Created by 沈方伟 on 16/1/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWHomeViewController.h"
#import "FWTitleButton.h"
#import "FWPopMenu.h"
#import "FWAccount.h"
#import "FWAccountTool.h"
#import "UIImageView+WebCache.h"
#import "FWStatus.h"
#import "FWUser.h"
#import "FWPhoto.h"
#import "MJExtension.h"
#import "FWLoadMoreFooter.h"
#import "FWStatusTool.h"
#import "FWUserTool.h"
#import "FWStatusFrame.h"
#import "FWStatusCell.h"
#import "LPFPSLabel.h"

#import "FWStatusDetailViewController.h"


@interface FWHomeViewController ()
/** 微博数组(存放所有的微博frame数据) */
@property (nonatomic, strong, nullable) NSMutableArray *statusFrames;

/** 加载更多数据 */
@property (nonatomic, strong, nullable) FWLoadMoreFooter *footer;

/** 标题按钮 */
@property(nonatomic, weak) FWTitleButton *titleBtn;

/** 刷新控件 */
@property(nonatomic, weak) UIRefreshControl *refreshControl;

@end

@implementation FWHomeViewController

- (NSMutableArray *)statusFrames{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray arrayWithCapacity:0];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = FWColor(211, 211, 211, 1.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置导航栏
    [self setupNavBar];
    
    //集成刷新控件
    [self setupRefreshControl];
    
    // 获取用户信息
    [self setupUserInfo];
    
    // 监听链接选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkDidSelected:) name:FWLinkDidSelectedNotificaion object:nil];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)linkDidSelected:(NSNotification *)note{
    NSString *linkTest = note.userInfo[HMLinkText];
    if ([linkTest hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkTest]];
    }else{
        //跳转控制器
    }
}
#pragma mark - 数据
#pragma mark 获取用户信息
- (void)setupUserInfo{
    FWUserInfoParam *param = [[FWUserInfoParam alloc] init];
    param.access_token = [FWAccountTool account].access_token;
    param.uid = [FWAccountTool account].uid;
    
    [FWUserTool userInfoWithParam:param success:^(FWUserInfoResult *result) {
        FWAccount *account = [FWAccountTool account];
        account.screen_name = result.name;
        [FWAccountTool save:account];
        
        [self.titleBtn setTitle:result.name forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        FWLog(@"请求失败:%@",error);
    }];
}

#pragma mark 刷新
- (void)pulledToRefresh:(UIRefreshControl *)refreshControl{
    
    FWHomeStatusParam *param = [[FWHomeStatusParam alloc] init];
    param.access_token = [FWAccountTool account].access_token;
    FWStatusFrame *statusFrame = [self.statusFrames firstObject];
    FWStatus *firstStatus = statusFrame.status;
    if (firstStatus.idstr) {
        param.since_id = firstStatus.idstr;
    }
    [FWStatusTool homeStatusWithParam:param success:^(FWHomeStatusesResult *result) {
        [MBProgressHUD hideHUD];
        NSArray *newStatuses = result.statuses;
        
        NSArray *statusFrameArr = [self statusFramesWithStatus:newStatuses];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatuses.count)];
        [self.statusFrames insertObjects:statusFrameArr atIndexes:indexSet];
        
        [self.tableView reloadData];
        
        //让刷新控件停止刷新(回复默认的状态)
        [refreshControl endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusesCount:newStatuses.count];
    } failure:^(NSError *error) {
        FWLog(@"请求失败:%@",error);
        [MBProgressHUD hideHUD];
        [refreshControl endRefreshing];
    }];
    
}

/**
 *  根据微博数组 转成 frame模型数组
 *
 *  @param status 根据微博数组
 */
- (NSArray *)statusFramesWithStatus:(NSArray *)status{
    NSMutableArray *frams = [NSMutableArray array];
    
    for (FWStatus *s in status) {
        FWStatusFrame *statusFrame = [[FWStatusFrame alloc] init];
        statusFrame.status = s;
        [frams addObject:statusFrame];
    }
    
    return frams;

}
#pragma mark 加载更多的微博数据
- (void)loadMoreStatuses{
    FWHomeStatusParam *param = [[FWHomeStatusParam alloc] init];
    param.access_token = [FWAccountTool account].access_token;
    FWStatusFrame *statusFrame = [self.statusFrames lastObject];
    FWStatus *lastStatus = statusFrame.status;
    
    if (lastStatus.idstr) {
        param.max_id = [NSString stringWithFormat:@"%lld",[lastStatus.idstr longLongValue] - 1];
    }
    
    [FWStatusTool homeStatusWithParam:param success:^(FWHomeStatusesResult *result) {
        NSArray *newStatus = result.statuses;
        
        NSArray *statusFrameArr = [self statusFramesWithStatus:newStatus];
        [self.statusFrames addObjectsFromArray:statusFrameArr];
        
        [self.tableView reloadData];
        
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        FWLog(@"加载跟多的微博数据错误:%@",error);
        [self.footer endRefreshing];
    }];
   
}

#pragma mark 刷新
- (void)refresh:(BOOL)fromSelf{
    
    
    if (fromSelf) {
        if (self.tabBarItem.badgeValue) {
            [self.refreshControl beginRefreshing];
            [self pulledToRefresh:self.refreshControl];
        }else{
            NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
   
    
}

#pragma mark - 逻辑
#pragma mark 点击中间按钮
- (void)titleButtonClick:(UIButton *)sender{
    [sender setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    FWPopMenu *popMenu = [[FWPopMenu alloc] initWithContentView:nil block:^{
        FWTitleButton *titleButton = (FWTitleButton *)self.navigationItem.titleView;
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }];
    popMenu.direction = FWPopMenuArrowDirectionMiddle;
    [popMenu showInRect:CGRectMake(0, 0, 200, 300)];
}

#pragma mark 好友动态
- (void)friendAttention{
    DLog(@"friendAttention");
}

#pragma mark 雷达
- (void)radar{
    DLog(@"radar");
}

#pragma mark - 视图
#pragma mark 设置导航栏
- (void)setupNavBar{
    //设置左右导航栏
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendattention" selectedImage:@"navigationbar_friendattention_highlighted" target:self action:@selector(friendAttention)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_icon_radar" selectedImage:@"navigationbar_icon_radar_highlighted" target:self action:@selector(radar)];
    
    //设置中间按钮
    FWTitleButton *titleBtn = [[FWTitleButton alloc] init];
    titleBtn.height = 35;
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    FWAccount *account = [FWAccountTool account];
    [titleBtn setTitle:account.screen_name ? account.screen_name : @"首页" forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage resizeImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = titleBtn;
//    self.titleBtn = titleBtn;
    
    LPFPSLabel *fpsLabel = [[LPFPSLabel alloc] initWithFrame:CGRectMake(10, 74, 50, 30)];
    [fpsLabel sizeToFit];
    self.navigationItem.titleView = fpsLabel;
}

#pragma mark 集成刷新控件
- (void)setupRefreshControl{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    
    [refreshControl addTarget:self action:@selector(pulledToRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [refreshControl beginRefreshing];
    
    [self pulledToRefresh:refreshControl];
    
    self.footer = [FWLoadMoreFooter footer];
    self.tableView.tableFooterView = self.footer;
    
    self.refreshControl = refreshControl;
}

#pragma mark 提示用户最新的微博数量
- (void)showNewStatusesCount:(NSUInteger)count{
    UILabel *label = [[UILabel alloc] init];
    
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%ld条数据",count];
    }else{
        label.text = @"没有最新的微博数据";
    }
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = KColor(whiteColor);
    
    label.width = KScreenWidth;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 1;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
    
}

#pragma makr FPS
- (void)setupFPSLabel{
//    LPFPSLabel *fpsLabel = [[LPFPSLabel alloc] initWithFrame:CGRectMake(10, 74, 50, 30)];
//    [fpsLabel sizeToFit];
//    [self.view addSubview:fpsLabel];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.footer.hidden = self.statusFrames.count == 0;
    return self.statusFrames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.statusFrames[indexPath.row] cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FWStatusCell *cell = [FWStatusCell cellWithTableView:tableView];
    
//    FWStatusFrame *statusFrame = self.statusFrames[indexPath.row];
//    cell.backgroundColor = KColor(clearColor);
//    
//    cell.statusFrame = statusFrame;

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FWStatusCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    FWStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    cell.backgroundColor = KColor(clearColor);
    
    cell.statusFrame = statusFrame;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FWStatusDetailViewController *detail = [[FWStatusDetailViewController alloc] init];
    FWStatusFrame *frame = self.statusFrames[indexPath.row];
    detail.status = frame.status;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.statusFrames.count <= 0 || self.footer.isRefreshing) return;
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatuses];
        });
    }

    
    
}
    
@end
