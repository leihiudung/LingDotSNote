//
//  NSData+Encryption.h
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/18.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Encryption)
- (NSData *)encryptOfAES256WithKey:(NSString *)key;
- (NSData *)decryptOfAES256WithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
