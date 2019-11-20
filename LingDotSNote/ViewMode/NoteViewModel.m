//
//  NoteViewModel.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/20.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "NoteViewModel.h"
#import "DatabaseTool.h"
#import "NoteModel.h"

@interface NoteViewModel()

@end

@implementation NoteViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadNoteFromDB:(void (^)(NSArray *))resultBlock {
    NSArray *resultArray = [[DatabaseTool share] readNoteData];
    NSMutableArray *noteModelArray = [NSMutableArray array];
    
    for (NSDictionary *tempDic in resultArray) {
        NoteModel *noteModel = [[NoteModel alloc]init];
        [noteModel setValuesForKeysWithDictionary:tempDic];
        [noteModelArray addObject:noteModel];
    }
    resultBlock(noteModelArray.copy);
}

@end
