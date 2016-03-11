//
//  FWTextView.m
//  FWWeibo
//
//  Created by travelzen on 16/2/16.
//  Copyright © 2016年 FrankShen. All rights reserved.
//

#import "FWTextView.h"

@interface FWTextView ()
/** 用于显示提醒文字 */
@property(nonatomic, weak) UILabel *placehoderLabel;
@end

@implementation FWTextView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加一个显示提醒文字的label(显示占位文字)
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = KColor(clearColor);
        
        placehoderLabel.textColor = KColor(lightGrayColor);
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        
        self.font = KFont(14);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

- (void)textDidChange{
    self.placehoderLabel.hidden = self.hasText;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlacehoder:(NSString *)placehoder{
    _placehoder = [placehoder copy];
    
    self.placehoderLabel.text = _placehoder;
    
    // 重新计算子控件的frame
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.placehoderLabel.font = font;
    
    // 重新计算子控件的frame
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    
    [self textDidChange];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.placehoderLabel.x = 5;
    self.placehoderLabel.y = 8;
    self.placehoderLabel.width = self.width - self.placehoderLabel.x * 2;
    self.placehoderLabel.height = [self.placehoder boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size.height;
}


@end
