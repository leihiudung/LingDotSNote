//
//  AddNoteViewController.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/12.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "AddNoteViewController.h"
#import "AddNoteView.h"
#import "AddnoteViewModel.h"

#import "ReactiveObjC.h"


@interface AddNoteViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    BOOL _keyboardStatus;
}
@property (nonatomic, strong) AddNoteView *addNoteView;

@property (nonatomic, strong) UIImagePickerController *pickerController;

@property (nonatomic, strong) AddNoteViewModel *viewModel;

@property (nonatomic, strong) RACSignal *zipSignal;

@property (nonatomic, strong) RACSignal *maxScreenSignal;

@property (nonatomic, assign) BOOL canCommit;
@end

@implementation AddNoteViewController

- (void)loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editNoteDone:)];
    
    _addNoteView = [[AddNoteView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_addNoteView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [self pickImageFromAlbum:x];
    }];
    [_addNoteView.getAddImageView addGestureRecognizer:tapGesture];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerController = [[UIImagePickerController alloc]init];
    self.pickerController.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStatsShowNotification:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStatsHiddenNotification:) name:UIKeyboardDidHideNotification object:nil];
    
    self.viewModel = [[AddNoteViewModel alloc]init];
    RAC(self.viewModel, message) = self.addNoteView.contentView.rac_textSignal;
//    RAC(self.viewModel, message) = [RACObserve(self.addNoteView.contentView, text) merge:self.addNoteView.contentView.rac_textSignal];
    
    RAC(self.viewModel, imageArray)  = [RACObserve(self.addNoteView, imageArray) merge:self.addNoteView.imageArray.rac_sequence.signal];
    
    self.zipSignal = [self.addNoteView.contentView.rac_textSignal zipWith:[RACObserve(self.addNoteView, addImageViewArray) merge:self.addNoteView.addImageViewArray.rac_sequence.signal] ];
    [[self.zipSignal map:^id _Nullable(id  _Nullable value) {
        
        return @(self.addNoteView.contentView.text.length > 0 || self.addNoteView.addImageViewArray.count > 1);
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"开始编写");
        self.canCommit = x;
    }];
    
    NSLog(@"done");
}

/**
 rightbarbutton为"完成"时的点击事件

 @param sender
 */
- (void)editNoteDone:(id)sender {
    [self.addNoteView resignFocus];
    // 当textfield有文字时,收起键盘,改变rightbarbutton
    if (_keyboardStatus) {
        if ([self.addNoteView contentView].text.length > 0) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布吧" style:UIBarButtonItemStyleDone target:self action:@selector(commitAction:)];
        } else {
            // 当textfield没有z文字时,则不改变
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(editNoteDone:)];
            
        }
        
    }
    
}

/**
 rightbarbutton为"发布吧"时的点击事件

 @param sender
 */
- (void)commitAction:(id)sender {

    if (self.canCommit) {
        // 写入数据到本地
        
        // 提交网络
        
    }

    __weak typeof(self)weakSelf = self;
    [self.viewModel addNoteInDatabase:^(BOOL flag, NSString * _Nonnull success) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)pickImageFromAlbum:(UIGestureRecognizer *)recognizer {
    [self presentViewController:self.pickerController animated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {

    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.addNoteView insertNewImage:originalImage andCallBack:^(UIImageView * _Nonnull imageView) {
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction:)]];
    }];
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)keyboardStatsShowNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    _keyboardStatus = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(editNoteDone:)];
}

- (void)keyboardStatsHiddenNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    _keyboardStatus = NO;
}

- (void)imageAction:(UIGestureRecognizer *)recognizer {
    
    
}
@end
