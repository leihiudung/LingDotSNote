//
//  HallViewController.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/11.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "HallViewController.h"
#import "NoteViewController.h"
#import "PersonalViewController.h"
#import "FoodViewController.h"
#import "MemoViewController.h"
#import "HallView.h"

@interface HallViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HallView *hallView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation HallViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initService];
    [self initData];
}

- (void)initView {
    self.hallView = [[HallView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.hallView];
    
}

- (void)initService {
    [self.hallView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    [self.hallView.tableView setDataSource:self];
    [self.hallView.tableView setDelegate:self];
    
    
}

- (void)initData {
    self.dataArray = @[@"日记", @"美食地图", @"待办事务"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.4;
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromRight;
//
//    [self.tabBarController.view.layer addAnimation:transition forKey:kCATransition];
    
    NoteViewController *noteController = [[NoteViewController alloc]init];
    FoodViewController *foodController = [[FoodViewController alloc]init];
    MemoViewController *memoController = [[MemoViewController alloc]init];
    
    UINavigationController *noteNaviController = [[UINavigationController alloc]initWithRootViewController:noteController];
    
    
    switch (indexPath.row) {
        case 0:
            [self presentViewController:noteNaviController animated:YES completion:nil];
            break;
        case 1:
//            [self presentViewController:foodController animated:NO completion:nil];
            break;
        default:
//            [self presentViewController:memoController animated:NO completion:nil];
            break;
    }
    
    
//    [self presentViewController:noteController animated:YES completion:nil];
    
}
@end
