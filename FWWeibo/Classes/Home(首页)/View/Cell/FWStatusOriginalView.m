//
//  FWStatusOriginalView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusOriginalView.h"
#import "FWStatusOriginalFrame.h"
#import "FWStatus.h"
#import "FWUser.h"
#import "UIImageView+WebCache.h"
#import "FWStatusPhotosView.h"
#import "FWStatusLabel.h"

@interface FWStatusOriginalView ()
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) FWStatusLabel *textLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/* 配图相册 */
@property (nonatomic, weak) FWStatusPhotosView *photosView;


@end
@implementation FWStatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HMStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        FWStatusLabel  *textLabel = [[FWStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = HMStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = HMStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
//        iconView.layer.cornerRadius = 34 / 2;
//        iconView.layer.masksToBounds = YES;
        self.iconView = iconView;
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 7.配图相册
        FWStatusPhotosView *photosView = [[FWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;

    }
    
    return self;
}

- (void)setOriginalFrame:(FWStatusOriginalFrame *)originalFrame {
    _originalFrame = originalFrame;
    self.frame = originalFrame.frame;
    
    FWStatus *status = originalFrame.status;
    FWUser *user = status.user;
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    
    if(user.isVip){
        self.nameLabel.textColor = KColor(orangeColor);
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
    }else{
        self.nameLabel.textColor = KColor(blackColor);
        self.vipView.hidden = YES;
    }
    
    // 2.正文（内容）
//    if (!status.isRetweeted) {
//        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedText];
//        int len = user.name.length + 4;
//        [text deleteCharactersInRange:NSMakeRange(0, len)];
//        self.textLabel.attributedText = text;
//    } else {
//        self.textLabel.attributedText = status.attributedText;
//    }
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedText];
//    int len = user.name.length + 2;
//    [text deleteCharactersInRange:NSMakeRange(0, len)];
//    self.textLabel.attributedText = text;
    self.textLabel.attributedText = status.attributedText;
    self.textLabel.frame = originalFrame.textFrame;
    
    // 3.时间
    NSString *time = status.created_at;
    self.timeLabel.text = time; // 刚刚 --> 1分钟前 --> 10分钟前
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + HMStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithAttributes:@{NSFontAttributeName :HMStatusOrginalTimeFont }];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
//    self.sourceLabel.text = status.source;
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HMStatusCellInset;
    CGFloat sourceY = timeY;
    self.sourceLabel.textColor = KColor(lightGrayColor);
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName :HMStatusOrginalTimeFont }];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.头像
    
    UIImageView *iconIV = [[UIImageView alloc] initWithFrame:originalFrame.iconFrame];
    
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue1 = dispatch_queue_create("1", NULL);
//    dispatch_queue_t queue2 = dispatch_queue_create("2", NULL);
//    
//    dispatch_group_async(group, queue1, ^{
//       [iconIV sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
//    });
//     WS(weakSelf);
//    UIImage *img = (__block)[[UIImage alloc] init];
//    
//    dispatch_group_async(group, queue2, ^{
//       img = [iconIV.image yal_imageWithRoundedCornersAndSize:CGSizeMake(34, 34) andCornerRadius:17];
//        weakSelf.iconView.image = img;
//    });
//    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        weakSelf.iconView.image = img;
//    });
//
    [iconIV sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = originalFrame.iconFrame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *img = [iconIV.image yal_imageWithRoundedCornersAndSize:CGSizeMake(34, 34) andCornerRadius:17];
        self.iconView.image = img;
    });
    
//    WS(weakSelf);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage *image = [iconIV.image yal_imageWithRoundedCornersAndSize:CGSizeMake(34, 34) andCornerRadius:17];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.iconView.image = image;
//        });
//    });
    
    
    
//    self.iconView.frame = originalFrame.iconFrame;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];

    
//    // 6.配图相册
    if (status.pic_urls.count) { // 有配图
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }

}


@end
