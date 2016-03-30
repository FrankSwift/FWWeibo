//
//  FWCommonGroup.h
//  FWWeibo
//
//  Created by 沈方伟 on 16/3/18.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWCommonGroup : NSObject
@property (nonatomic, copy, nullable) NSString *header; ///<组头

@property (nonatomic, copy, nullable) NSString *footer; ///<组尾

@property (nonatomic, copy, nullable) NSArray *items; ///<这组所有的模型(item模型)

+ (instancetype)group;
@end
