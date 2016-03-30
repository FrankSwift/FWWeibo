//
//  FWStatusToolBar.m
//  FWWeibo
//
//  Created by travelzen on 16/2/22.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWStatusToolBar.h"

@interface FWStatusToolBar ()

@end
@implementation FWStatusToolBar
- (void)drawRect:(CGRect)rect{
    [[UIImage resizeImage:@"timeline_card_bottom_background"] drawInRect:rect];
}
@end
