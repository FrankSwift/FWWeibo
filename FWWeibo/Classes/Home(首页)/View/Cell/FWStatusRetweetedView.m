//
//  FWStatusRetweetedView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusRetweetedView.h"
#import "FWStatusRetweetedFrame.h"
#import "FWStatus.h"
#import "FWUser.h"
#import "FWStatusPhotosView.h"

@interface FWStatusRetweetedView()
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textLabel;
/* 配图相册 */
@property (nonatomic, weak) FWStatusPhotosView *photosView;

@end
@implementation FWStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.image = [UIImage resizeImage:@"timeline_retweet_background"];
        self.highlightedImage = [UIImage resizeImage:@"timeline_retweet_background_highlighted"];
        self.userInteractionEnabled = YES;
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HMStatusRetweetedNameFont;
        nameLabel.textColor = FWColor(74, 102, 105, 1.0);
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.font = HMStatusRetweetedTextFont;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.配图相册
        FWStatusPhotosView *photosView = [[FWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
    }
    
    return self;
}

- (void)setRetweetedFrame:(FWStatusRetweetedFrame *)retweetedFrame{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    FWStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    
    // 1.正文（内容）
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 2.配图相册
    if (retweetedStatus.pic_urls.count) { // 有配图
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    // 3.工具条
//    if (retweetedStatus.isDetail) {
//        self.toolbar.frame = retweetedFrame.toolbarFrame;
//        self.toolbar.status = retweetedFrame.retweetedStatus;
//        self.toolbar.hidden = NO;
//    } else {
//        self.toolbar.hidden = YES;
//    }

}

@end
