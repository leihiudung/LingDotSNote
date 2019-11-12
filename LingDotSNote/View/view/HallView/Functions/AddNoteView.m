//
//  AddNoteView.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/12.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "AddNoteView.h"

#import <Masonry.h>

@interface AddNoteView()
@property (nonatomic, strong) UITextView *contentView;

@property (nonatomic, strong) UIView *imageContainerView;

@property (nonatomic, strong) UIImageView *addImageView;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *addImageViewArray;

@end

@implementation AddNoteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];

    }
    return self;
}

- (void)initView {
    _contentView = [[UITextView alloc]init];
    [self addSubview:_contentView];
    
    _imageContainerView = [[UIView alloc]init];
    [self addSubview:_imageContainerView];
    _addImageView = [[UIImageView alloc]init];
    [_imageContainerView addSubview:_addImageView];
    
    [self initConstraint];
    [self resignFocus];
}

- (void)initConstraint {
    _addImageViewArray addObject:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]]
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    [_imageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.top.mas_offset(self.contentView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [_addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageContainerView.mas_top);
        make.width.mas_equalTo(self.imageContainerView.mas_width).multipliedBy(0.3);
        make.left.mas_equalTo(self.imageContainerView.mas_left).mas_offset();
    }];
}

- (void)resignFocus {
    [_contentView resignFirstResponder];
    
}

-(void)initEvent {
    
}
@end
