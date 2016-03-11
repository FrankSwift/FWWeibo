//
//  FWSearchBar.m
//  FWWeibo
//
//  Created by travelzen on 16/2/6.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWSearchBar.h"

@implementation FWSearchBar

+(instancetype)searchBar{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.background = [UIImage resizeImage:@"searchbar_textfield_background"];
        
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.image.size.height;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView.contentMode = UIViewContentModeCenter;
        
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    return self;
}
@end
