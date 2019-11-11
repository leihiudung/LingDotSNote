//
//  HallViewController.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/11.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "HallViewController.h"
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
    
}
@end
