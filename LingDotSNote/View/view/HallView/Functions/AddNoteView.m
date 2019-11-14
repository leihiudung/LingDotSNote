//
//  AddNoteView.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/12.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "AddNoteView.h"
#import <ReactiveObjC.h>
#import <Masonry.h>

@interface AddNoteView()
//@property (nonatomic, strong) UITextView *contentView;

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
    [_addImageView setUserInteractionEnabled:YES];
    [_imageContainerView addSubview:_addImageView];
    
    _addImageViewArray = [NSMutableArray array];
    [_addImageViewArray addObject:_addImageView];
    
//    CALayer *contentLayer = _contentView.layer;
    _imageContainerView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:250/255.0 alpha:1];
    
    [self initConstraint];
    [self resignFocus];
    
}

- (void)initConstraint {
    [_addImageView setImage:[UIImage imageNamed:@"add_image_big"]];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.7);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    [_imageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width);
        make.top.mas_equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [_addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageContainerView.mas_top).mas_offset(12);
        make.width.mas_equalTo(self.imageContainerView.mas_width).multipliedBy(0.3);
        make.height.mas_equalTo(self.imageContainerView.mas_width).multipliedBy(0.3);
        make.left.mas_equalTo(self.imageContainerView.mas_left).mas_offset(self.frame.size.width * 0.025);
    
    }];
}

- (void)resignFocus {
    [_contentView resignFirstResponder];
    
}

-(void)initEvent {
    [[_contentView.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 0;
    }] subscribeNext:^(NSString * _Nullable x) {
        
    }];
}

//- (UITextView *)getContentView {
//    return self.contentView;
//}

- (UIImageView *)getAddImageView {
    return self.addImageView;
}

- (NSArray<UIImageView *> *)getImages {
    return self.addImageViewArray.copy;
}

- (void)insertNewImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [_imageContainerView addSubview:imageView];
    
    [_addImageViewArray insertObject:imageView atIndex:0];
    
    [self updateImageConstraints];
}

- (void)updateImageConstraints {
    int offsetCount = (_addImageViewArray.count - 1) % 3;
    int containerWidth = _imageContainerView.frame.size.width;
    
    
    int ColumnCount = 3;
    for (int i = 1; i < _addImageViewArray.count; i++) {
        UIImageView *tempImageView = _addImageViewArray[i];
        
        [tempImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageContainerView.mas_left).mas_offset(i % ColumnCount * (containerWidth * 0.3) + self.frame.size.width * 0.025 * (i % ColumnCount + 1));
            make.top.mas_equalTo(self.imageContainerView.mas_top).mas_offset(12 + (i / ColumnCount) * (containerWidth * 0.3) + 12 * (i / ColumnCount));
        }];
        
    }
    
    UIImageView *tempImageView = _addImageViewArray[0];
    [tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageContainerView.mas_top).mas_offset(12);
        make.width.mas_equalTo(self.imageContainerView.mas_width).multipliedBy(0.3);
        make.height.mas_equalTo(self.imageContainerView.mas_width).multipliedBy(0.3);
        make.left.mas_equalTo(self.imageContainerView.mas_left).mas_offset(self.frame.size.width * 0.025);
    }];
}
@end
