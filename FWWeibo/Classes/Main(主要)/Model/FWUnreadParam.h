//
//  FWUnreadParam.h
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWBaseParam.h"


@interface FWUnreadParam : FWBaseParam

/** 需要获取消息未读数的用户UID，必须是当前登录用户。 */
@property (nonatomic, copy) NSString *uid;

@end
