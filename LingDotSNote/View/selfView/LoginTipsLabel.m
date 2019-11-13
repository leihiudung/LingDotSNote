//
//  LoginTipsLabel.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/8.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "LoginTipsLabel.h"

@implementation LoginTipsLabel {
    UIEdgeInsets _edgeInsets;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame inset:(UIEdgeInsets)edgeInsets {
    if (self = [super initWithFrame:frame]) {
        _edgeInsets = edgeInsets;
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    
    [super drawRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 0, 0, 0))];
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _edgeInsets)];
}

// 修改绘制文字的区域，edgeInsets增加bounds
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    /*
     调用父类该方法
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
                                                                 _edgeInsets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= _edgeInsets.left;
    rect.origin.y -= _edgeInsets.top;
    rect.size.width += _edgeInsets.left + _edgeInsets.right;
    rect.size.height += _edgeInsets.top + _edgeInsets.bottom;
    return rect;
}
@end
