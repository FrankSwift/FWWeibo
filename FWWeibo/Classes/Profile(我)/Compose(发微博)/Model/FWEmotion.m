//
//  FWEmotion.m
//  FWWeibo
//
//  Created by travelzen on 16/2/24.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWEmotion.h"
#import "MJExtension.h"
#import "NSString+Emoji.h"
@implementation FWEmotion

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"coder" : @"code"};
}

- (void)setCoder:(NSString *)coder{
    _coder = [coder copy];
    
    if (coder == nil) return;
    self.emoji = [NSString emojiWithStringCode:coder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.coder forKey:@"coder"];
    [aCoder encodeObject:self.finderPath forKey:@"finderPath"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.chs = [coder decodeObjectForKey:@"chs"];
        self.png = [coder decodeObjectForKey:@"png"];
        self.coder = [coder decodeObjectForKey:@"coder"];
        self.finderPath = [coder decodeObjectForKey:@"finderPath"];
    }
    return self;
}

-(BOOL)isEqual:(FWEmotion *)otherEmotion{
    if (self.coder) {
        return [self.coder isEqualToString:otherEmotion.coder];
    }else{
        return [self.png isEqualToString:otherEmotion.png] && [self.chs isEqualToString:otherEmotion.chs];
    }
}
@end
