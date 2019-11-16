//
//  DatabaseTool.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/15.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "DatabaseTool.h"
@interface DatabaseTool()

@end

@implementation DatabaseTool

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static DatabaseTool *databaseTool = nil;
    dispatch_once(&onceToken, ^{
        databaseTool = [[DatabaseTool alloc]init];
    });
    return databaseTool;
}

- (void)insertNoteData:(NSString *)content andImage:(nullable NSArray<UIImage *> *)imageArray {
    
}
@end
