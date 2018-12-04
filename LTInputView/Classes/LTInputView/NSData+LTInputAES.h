//
//  NSData+LTInputAES.h
//  LTInputView
//
//  Created by yelon on 2018/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LTInputAES)

- (NSData *)lt_aes256EncryptWithKey:(NSString *)key;

- (NSData *)lt_aes256DecryptWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
