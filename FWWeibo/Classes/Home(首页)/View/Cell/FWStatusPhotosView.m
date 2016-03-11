//
//  FWStatusPhotosView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/22.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusPhotosView.h"
#import "FWStatusPhotoView.h"
#import "MWPhotoBrowser.h"
#import "FWPhoto.h"
//#import "UIImageView+WebCache.h"

#define HMStatusPhotosMaxCount 9
#define HMStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define HMStatusPhotoW (KScreenWidth - 40) / 3
#define HMStatusPhotoH HMStatusPhotoW
#define HMStatusPhotoMargin 10

@interface FWStatusPhotosView ()<MWPhotoBrowserDelegate>
/** 照片数组 */
@property (nonatomic, strong) NSMutableArray *photos;

/** 图片浏览器 */
@property(nonatomic, weak) MWPhotoBrowser *browser;

@end

@implementation FWStatusPhotosView

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray arrayWithCapacity:0];
    }
    return _photos;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        for (int i =0; i < HMStatusPhotosMaxCount; i ++) {
            FWStatusPhotoView *photoView = [[FWStatusPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    for (int i = 0;  i < self.pic_urls.count; i ++) {
        FWPhoto *pic = self.pic_urls[i];
        
        NSURL *url = [NSURL URLWithString:pic.bmiddle_pic];
        MWPhoto *photo = [[MWPhoto alloc] initWithURL:url];
        [self.photos addObject:photo];
    }
    
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    self.browser = browser;
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = YES; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Customise selection images to change colours if required
//    browser.customImageSelectedIconName = @"ImageSelected.png";
//    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Optionally set the current visible photo before displaying
//    [browser setCurrentPhotoIndex:recognizer.view.tag];
    [browser setCurrentPhotoIndex:recognizer.view.tag];
    
    // Present
//    [self.navigationController pushViewController:browser animated:YES];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:browser.view];
    [window.rootViewController addChildViewController:browser];
    
    
    // Manipulate
//    [browser showNextPhotoAnimated:YES];
//    [browser showPreviousPhotoAnimated:YES];
//    [browser setCurrentPhotoIndex:self.pic_urls.count];
    
    UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapBrowser)];
    [self.browser.view addGestureRecognizer:tap];
    
}

- (void)tapBrowser{
    [UIView animateWithDuration:1.0f animations:^{
         [self.browser.view removeFromSuperview];
        self.browser = nil;
    }];
}
+ (CGSize)sizeWithPhotosCount:(NSUInteger)photosCount
{
    int maxCols = HMStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * HMStatusPhotoW + (totalCols - 1) * HMStatusPhotoMargin;
    
    CGFloat photosH = totalRows * HMStatusPhotoH + (totalRows - 1) * HMStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

- (void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < HMStatusPhotosMaxCount; i ++) {
        FWStatusPhotoView *photoView = self.subviews[i];

        if (i < pic_urls.count) {
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.pic_urls.count;
    int maxCols = HMStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        FWStatusPhotoView *photoView = self.subviews[i];
        photoView.width = HMStatusPhotoW;
        photoView.height = HMStatusPhotoH;
        photoView.x = (i % maxCols) * (HMStatusPhotoW + HMStatusPhotoMargin);
        photoView.y = (i / maxCols) * (HMStatusPhotoH + HMStatusPhotoMargin);
    }
}


#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

@end
