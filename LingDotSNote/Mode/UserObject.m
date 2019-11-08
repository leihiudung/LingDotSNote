//
//  UserObject.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/8.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "UserObject.h"
@interface UserObject()
@property (nonatomic, strong) NSString *userNameStr;
@property (nonatomic, strong) NSString *passwordStr;

@end

@implementation UserObject

- (instancetype)initWithInfo:(NSString *)userName andPWD:(NSString *)password
{
    self = [super init];
    if (self) {
        self.userNameStr = userName;
        self.passwordStr = password;
        
    }
    return self;
}


@end
