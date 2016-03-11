//
//  FWAccount.m
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWAccount.h"

@implementation FWAccount


- (void)setExpires_in:(NSString *)expires_in{
    _expires_in = [expires_in copy];
    
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    self.expires_time = [now dateByAddingTimeInterval:expires_in.doubleValue];
}
/**
 *  当从文件中读取一个对象的时候调用
 *
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.screen_name forKey:@"screen_name"];
}
@end
