//
//  FWStatusRetweetedFrame.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusRetweetedFrame.h"
#import "FWStatus.h"
#import "FWUser.h"
#import "FWStatusPhotosView.h"


@implementation FWStatusRetweetedFrame

- (void)setRetweetedStatus:(FWStatus *)retweetedStatus{
    _retweetedStatus = retweetedStatus;
    
    // 0.昵称
//    NSString *username = [NSString stringWithFormat:@"@%@:",retweetedStatus.user];
//    CGFloat nameX = HMStatusCellInset;
//    CGFloat maxW = KScreenWidth - 2 * nameX;
//    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
//    CGSize nameSize = [username boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : HMStatusRetweetedNameFont} context:nil].size;
//    CGFloat nameY = HMStatusCellInset * 0.5;
//    CGFloat nameW = nameSize.width;
//    CGFloat nameH = nameSize.height;
//    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    NSString *retext = [NSString stringWithFormat:@"@%@:%@",retweetedStatus.user.name,retweetedStatus.text];
    // 1.正文
    CGFloat h = 0;
    CGFloat textX = HMStatusCellInset;
    CGFloat textY = HMStatusCellInset * 0.5;
    CGFloat maxW = KScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retext boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : HMStatusRetweetedTextFont} context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
   
    
    // 2.配图相册
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + HMStatusCellInset * 0.5;
        CGSize photosSize = [FWStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        h = CGRectGetMaxY(self.photosFrame) + HMStatusCellInset;
    }else{
         h = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
    }
    
    // 3.工具条
//    if (retweetedStatus.isDetail) { // 展示在详情里面， 需要显示toolbar
//        CGFloat toolbarY = 0;
//        CGFloat toolbarW = 200;
//        CGFloat toolbarX = HMScreenW - toolbarW;
//        CGFloat toolbarH = 20;
//        if (retweetedStatus.pic_urls.count) {
//            toolbarY = CGRectGetMaxY(self.photosFrame) + HMStatusCellInset;
//        } else {
//            toolbarY = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
//        }
//        self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
//        h = CGRectGetMaxY(self.toolbarFrame) + HMStatusCellInset;
//    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = KScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}
@end
