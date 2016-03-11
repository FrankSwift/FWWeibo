//
//  FWEmotion.h
//  FWWeibo
//
//  Created by travelzen on 16/2/24.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWEmotion : NSObject<NSCoding>

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *cht;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *coder;

/** emoji表情的路径 */
@property (nonatomic, copy) NSString *finderPath;

/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;

@end
