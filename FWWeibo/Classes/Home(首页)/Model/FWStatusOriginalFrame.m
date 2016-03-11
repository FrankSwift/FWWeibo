//
//  FWStatusOriginalFrame.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusOriginalFrame.h"
#import "FWStatus.h"
#import "FWUser.h"
#import "FWStatusPhotosView.h"

@implementation FWStatusOriginalFrame

- (void)setStatus:(FWStatus *)status{
    _status = status;
    
    // 1.头像
    CGFloat iconX = HMStatusCellInset;
    CGFloat iconY = HMStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + HMStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName : HMStatusOrginalNameFont}];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + HMStatusCellInset * 0.5;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + HMStatusCellInset * 0.5;
    CGFloat maxW = KScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 删掉最前面的昵称
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedText];
//    if (status.isRetweeted) {
//        int len = status.user.name.length + 4;
//        [text deleteCharactersInRange:NSMakeRange(0, len)];
//    }
    
    CGSize textSize = [status.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : KFont(14)} context:nil].size;

    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 4.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + HMStatusCellInset * 0.5;
        CGSize photosSize = [FWStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + HMStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = KScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
    
}
@end
