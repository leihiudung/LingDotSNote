//
//  LoginController.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/8.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "LoginController.h"

#import "LoginView.h"


#import <Masonry.h>

@interface LoginController ()

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, (UIScreen.mainScreen.bounds.size.height - 400) / 2, UIScreen.mainScreen.bounds.size.width, 400)];
    [self.view addSubview:self.loginView];
    
    [self.loginView.btnOfSignin addTarget:self action:@selector(signinAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)signinAction:(id)sender {
    
}

@end
