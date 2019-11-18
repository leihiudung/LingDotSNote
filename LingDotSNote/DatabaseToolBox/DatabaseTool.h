//
//  DatabaseTool.h
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/15.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseTool : NSObject
+ (instancetype)share;

/**
 保存日记内容和图片

 @param content 日记内容
 @param imageArray 图片
 */
- (void)insertNoteData:(NSString *)content andImage:(nullable NSArray<UIImage *> *)imageArray andResultBlock:(void (^)(NSString *))resultBlock;
@end

NS_ASSUME_NONNULL_END
