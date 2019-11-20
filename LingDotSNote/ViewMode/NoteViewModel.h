//
//  NoteViewModel.h
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/20.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoteViewModel : NSObject
/**
 从数据库中加载日志数据
 */
- (void)loadNoteFromDB:(void (^)(NSArray *))resultBlock;
@end

NS_ASSUME_NONNULL_END
