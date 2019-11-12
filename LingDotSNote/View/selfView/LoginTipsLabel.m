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
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, -50, 0, 50))];
}
@end
