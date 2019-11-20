//
//  NoteViewController.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/11.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "NoteViewController.h"
#import "NotesTableView.h"
#import "AddNoteViewController.h"

#import "DatabaseTool.h"
#import "NoteViewModel.h"

#import "NoteModel.h"

@interface NoteViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NotesTableView *tableView;
@property (nonatomic, strong) NoteViewModel *noteViewModel;
@property (nonatomic, strong) NSArray *noteArray;
@end

@implementation NoteViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[NotesTableView alloc]initWithFrame:self.view.frame];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.view addSubview:self.tableView];
    
    self.noteArray = [NSArray array];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backToHall:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    DatabaseTool *databaseTool = [DatabaseTool share];
    self.noteViewModel = [[NoteViewModel alloc]init];
    
    [self.noteViewModel loadNoteFromDB:^(NSArray * _Nonnull noteModelArray) {
        self.noteArray = noteModelArray;
    }];
}

/**
 返回上一页

 @param sender 事件对象
 */
- (void)backToHall:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 添加日记

 @param sender 事件对象
 */
- (void)addNote:(id)sender {
    // 跳到写日记controller
    AddNoteViewController *addController = [[AddNoteViewController alloc]init];
    [self.navigationController pushViewController:addController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 显示日记详情
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noteArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NoteModel *noteModel = self.noteArray[indexPath.row];
    cell.textLabel.text = noteModel.contentStr;
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
}
@end
