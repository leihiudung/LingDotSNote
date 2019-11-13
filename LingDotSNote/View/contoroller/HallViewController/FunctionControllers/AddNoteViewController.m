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

@interface AddNoteViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
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
    
}

- (void)editNoteDone:(id)sender {
    
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


@end
