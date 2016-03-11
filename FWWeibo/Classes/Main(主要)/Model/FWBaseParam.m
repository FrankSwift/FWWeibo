//
//  FWBaseParam.m
//  FWWeibo
//
//  Created by travelzen on 16/2/19.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWBaseParam.h"
#import "FWAccount.h"
#import "FWAccountTool.h"

@implementation FWBaseParam

- (instancetype)init{
    if (self = [super init]) {
        self.access_token = [FWAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param{
    return [[self alloc] init];
}
@end
