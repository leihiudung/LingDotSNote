//
//  LoginView.h
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/8.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginTipsLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView

@property (nonatomic, strong) LoginTipsLabel *nameTipsView;
@property (nonatomic, strong) UILabel *passwordTipsView;

@property (nonatomic, strong) UITextField *nameView;
@property (nonatomic, strong) UITextField *passwordView;

@property (nonatomic, strong) UIButton *signinBtn;
@property (nonatomic, strong) UIButton *signupBtn;

- (UIButton *)btnOfSignin;

- (void)resignFoucs;
@end

NS_ASSUME_NONNULL_END
