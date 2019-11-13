//
//  AddNoteViewController.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/12.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "AddNoteViewController.h"
#import "AddNoteView.h"

#import <ReactiveObjC.h>

@interface AddNoteViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    BOOL _keyboardStatus;
}
@property (nonatomic, strong) AddNoteView *addNoteView;

@property (nonatomic, strong) UIImagePickerController *pickerController;
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
}

- (void)editNoteDone:(id)sender {
    [self.addNoteView resignFocus];
    // 当textfield有文字时,收起键盘,改变rightbarbutton
    if (_keyboardStatus) {
        if ([self.addNoteView getContentView].text.length > 0) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布吧" style:UIBarButtonItemStyleDone target:self action:@selector(commitAction:)];
        } else {
            // 当textfield没有z文字时,则不改变
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(editNoteDone:)];
            
        }
        
    } else {
        
    }
    
    
    
}

- (void)commitAction:(id)sender {
    
}

- (void)pickImageFromAlbum:(UIGestureRecognizer *)recognizer {
    [self presentViewController:self.pickerController animated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {

    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
    
    [self.addNoteView insertNewImage:originalImage];
    
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
@end
