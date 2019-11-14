//
//  AddNoteView.h
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/12.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddNoteView : UIView
@property (nonatomic, strong) UITextView *contentView;
- (void)resignFocus;
- (UIImageView *)getAddImageView;
//- (UITextView *)getContentView;
- (void)insertNewImage:(UIImage *)image;
- (NSArray<UIImageView *> *)getImages;
@end

NS_ASSUME_NONNULL_END
