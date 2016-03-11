//
//  FWStatusPhotoView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/22.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusPhotoView.h"
#import "FWPhoto.h"
#import "UIImageView+WebCache.h"

@interface FWStatusPhotoView ()
@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation FWStatusPhotoView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    
    return self;
}
- (void)setPhoto:(FWPhoto *)photo{
    _photo = photo;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    // 2.控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
