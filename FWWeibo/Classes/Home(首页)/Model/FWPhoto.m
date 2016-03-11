//
//  FWPhoto.m
//  FWWeibo
//
//  Created by travelzen on 16/2/15.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWPhoto.h"

@implementation FWPhoto

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
