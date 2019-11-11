//
//  HallView.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/11.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "HallView.h"
@interface HallView()

@end

@implementation HallView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.tableView];
    
}
@end
