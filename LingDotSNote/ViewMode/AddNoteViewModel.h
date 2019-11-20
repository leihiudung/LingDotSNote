//
//  AddNoteViewModel.h
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/14.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddNoteViewModel : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSMutableArray<UIImage *> *imageArray;
@property (nonatomic, strong) NSEnumerator<UIImage *> *imageEnumerator;
- (void)commitNote:(NSString *)contentStr;
- (void)addNoteInDatabase:(void (^)(BOOL, NSString *))successBlock;
@end

NS_ASSUME_NONNULL_END
