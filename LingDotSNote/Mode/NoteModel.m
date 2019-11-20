//
//  NoteModel.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/20.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "NoteModel.h"
#import "NoteEnum.h"

@interface NoteModel()

@end

@implementation NoteModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.contentStr = keyedValues[@"content"];
    self.createDateStr = keyedValues[@"date"];
    self.noteStates = (int)keyedValues[@"note_states"];
//    self. keyedValues[@"create_time"];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
