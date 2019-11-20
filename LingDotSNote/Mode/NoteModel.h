//
//  NoteModel.h
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/20.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "NoteEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteModel : NSObject
@property (nonatomic, strong) NSString *contentStr;
@property (nonatomic, strong) NSString *createDateStr;
@property (nonatomic, strong) NSArray<NSString *> *contentImgArray;

@property (nonatomic, strong) NSString *weatherStr;
@property (nonatomic, assign) NoteVisibleState noteStates;

@end

NS_ASSUME_NONNULL_END
