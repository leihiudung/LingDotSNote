//
//  LoginView.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/8.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "LoginView.h"
#import "LoginTipsLabel.h"
#import <Masonry.h>

@interface LoginView()
@property (nonatomic, strong) LoginTipsLabel *nameTipsView;
@property (nonatomic, strong) UILabel *passwordTipsView;

@property (nonatomic, strong) UITextField *nameView;
@property (nonatomic, strong) UITextField *passwordView;

@property (nonatomic, strong) UIButton *signinBtn;
@property (nonatomic, strong) UIButton *signupBtn;

@end

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self initView];
//    }
//    return self;
//}

- (void)initView {
    self.nameTipsView = [[LoginTipsLabel alloc]init];
    self.passwordTipsView = [[UILabel alloc]init];
    
    self.nameView = [[UITextField alloc]init];
    self.passwordView = [[UITextField alloc]init];
    
    [self addSubview:self.nameTipsView];
    [self addSubview:self.passwordTipsView];
    
    [self addSubview:self.nameView];
    [self addSubview:self.passwordView];
    
    self.signinBtn = [[UIButton alloc]init];
    self.signupBtn = [[UIButton alloc]init];
    
    [self addSubview:self.signinBtn];
    [self addSubview:self.signupBtn];
    
    [self initConstraint];
    [self initContent];

}

- (void)initConstraint {
    [self.nameTipsView setTextAlignment:NSTextAlignmentRight];
    [self.nameTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.2);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.mas_left).mas_offset(self.frame.size.width * 0.1);
        make.top.mas_equalTo(100);
    }];
    
    [self.passwordTipsView setTextAlignment:NSTextAlignmentRight];
    [self.passwordTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.2);
       make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.mas_left).mas_offset(self.frame.size.width * 0.1);
        make.top.mas_equalTo(self.nameTipsView.mas_bottom).mas_offset(22);
    }];
    
    [self.nameView setTextAlignment:NSTextAlignmentLeft];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.6);
        make.left.mas_equalTo(self.nameTipsView.mas_right);
        make.top.mas_equalTo(self.nameTipsView.mas_top);
    }];
    
    [self.passwordView setTextAlignment:NSTextAlignmentLeft];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.6);
        make.left.mas_equalTo(self.passwordTipsView.mas_right);
        make.top.mas_equalTo(self.passwordTipsView.mas_top);
    }];
    
    [self.signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.8);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.passwordView.mas_bottom).mas_offset(24);
    }];

    [self.signinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.8);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.signupBtn.mas_bottom).mas_offset(14);
    }];
}

- (void)initContent {
    
    self.nameTipsView.text = NSLocalizedString(@"LV_name_tips_view", @"");
    self.passwordTipsView.text = NSLocalizedString(@"LV_password_tips_view", @"");
    
    self.nameView.placeholder = NSLocalizedString(@"LV_name_placehoder_view", @"");
    self.passwordView.placeholder = NSLocalizedString(@"LV_password_placeholder_view", @"");
    
    [self.signupBtn setTitle:NSLocalizedString(@"LV_btn_sign_up", @"") forState:UIControlStateNormal];
    [self.signinBtn setTitle:NSLocalizedString(@"LV_btn_sing_in", @"") forState:UIControlStateNormal];
    
    [self.signupBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.signinBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    [self.signupBtn setBackgroundColor:[UIColor redColor]];
    [self.signinBtn setBackgroundColor:[UIColor colorWithRed:123/255.0 green:104/255.0 blue:238/255.0 alpha:1]];
    
    CALayer *signupLayer = self.signupBtn.layer;
    signupLayer.cornerRadius = 16;
    signupLayer.masksToBounds = YES;
    
    CALayer *signinBtn = self.signinBtn.layer;
    signinBtn.cornerRadius = 16;
    signinBtn.masksToBounds = YES;
    
    [self.nameView setValue:@10 forKey:@"paddingLeft"];
    [self.passwordView setValue:@10 forKey:@"paddingLeft"];
    
    [self.nameView setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passwordView setBorderStyle:UITextBorderStyleRoundedRect];
    
    
}

- (UIButton *)btnOfSignin {
    return self.signinBtn;
}



@end
