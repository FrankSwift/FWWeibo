//
//  FWLink.h
//  FWWeibo
//
//  Created by 沈方伟 on 16/3/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWLink : NSObject

@property (nonatomic, copy, nullable) NSString *text; ///<链接文字

@property (nonatomic, assign) NSRange range; ///<链接范围

@property (nonatomic, strong, nullable) NSArray *rects; ///<链接的矩形框
@end
