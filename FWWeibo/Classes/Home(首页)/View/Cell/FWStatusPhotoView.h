//
//  FWStatusPhotoView.h
//  FWWeibo
//
//  Created by travelzen on 16/2/22.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWPhoto;
@interface FWStatusPhotoView : UIImageView

/** 图片模型 */
@property (nonatomic, strong, nullable) FWPhoto *photo;
@end
