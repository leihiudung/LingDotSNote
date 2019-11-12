//
//  LoginController.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/8.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "LoginController.h"
#import "HallViewController.h"
#import "PersonalViewController.h"
#import "LoginView.h"


#import <Masonry.h>
#import <ReactiveObjC.h>

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
    
    RACSignal *nameSignal = [self.loginView.nameView rac_signalForControlEvents:UIControlEventEditingChanged];
    RACSignal *passworkSignal = [self.loginView.passwordView rac_signalForControlEvents:UIControlEventEditingChanged];

    
    RACSignal *canSigninSignal = [nameSignal zipWith:passworkSignal];
    
    
    [canSigninSignal subscribeNext:^(id  _Nullable x) {
        [self.loginView.btnOfSignin setBackgroundColor:[UIColor colorWithRed:123/255.0 green:104/255.0 blue:238/255.0 alpha:1]];
        [self.loginView.btnOfSignin setEnabled:YES];
    }];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]init];
    [tapRecognizer.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [self.loginView resignFoucs];
    }];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)signinAction:(id)sender {
    HallViewController *controller = [[HallViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    navigationController.title = NSLocalizedString(@"HVC_tabbar_title", @"");
    PersonalViewController *personalController = [[PersonalViewController alloc]init];
    personalController.tabBarItem.title = NSLocalizedString(@"PVC_tabbar_title", @"");
    
    UITabBarController *tabbarController = [[UITabBarController alloc]init];
    tabbarController.viewControllers = @[navigationController, personalController];
//    tabbarController
    [self presentViewController:tabbarController animated:YES completion:nil];
    
}

@end
