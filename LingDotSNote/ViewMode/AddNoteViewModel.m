//
//  AddNoteViewModel.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/14.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "AddNoteViewModel.h"
#import "DatabaseTool.h"

typedef void (^addNote) (NSString *);
@interface AddNoteViewModel()

@end

@implementation AddNoteViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initRAC];
    }
    return self;
}

- (void)initRAC {
    [RACObserve(self, message) subscribeNext:^(id  _Nullable x) {
        NSLog(@"done1");
    }];
    
    [RACObserve(self, imageArray) subscribeNext:^(id  _Nullable x) {
        NSLog(@"done2");
    }];
}

- (void)addNoteInDatabase:(void (^)(BOOL, NSString *))successBlock {
    [[DatabaseTool share] insertNoteData:self.message andImage:self.imageArray andResultBlock:^(BOOL flag, NSString * _Nonnull resultMsg) {
//        if (flag) {
            successBlock(flag, resultMsg);
//        }
    }];
}

- (void)commitNote:(NSString *)contentStr {
    
    
}
@end
