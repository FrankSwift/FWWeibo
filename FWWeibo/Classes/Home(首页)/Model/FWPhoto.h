//
//  FWPhoto.h
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWPhoto : NSObject

/** 缩略图 */
@property (nonatomic, copy, nullable) NSString *thumbnail_pic;

/** 大图 */
@property (nonatomic, copy, nullable) NSString *bmiddle_pic;
@end
