//
//  FWHomeStatusesResult.m
//  FWWeibo
//
//  Created by travelzen on 16/2/17.
//  Copyright © 2016年 FrankShen. All rights reserved.
//  

#import "FWHomeStatusesResult.h"
#import "MJExtension.h"
#import "FWStatus.h"


@implementation FWHomeStatusesResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"statuses" : [FWStatus class]};
}
@end
