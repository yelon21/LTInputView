//
//  NSData+LTInputAES.h
//  LTInputView
//
//  Created by yelon on 2018/12/4.
//

#import <Foundation/Foundation.h>

@interface NSData (LTInputAES)

+ (NSData *)randomBytes:(const int)size;

//- (NSData *)lt_aes256EncryptWithKey:(NSString *)key;
- (NSData *)lt_aes256EncryptWithKeyBytes:(const void *)key;

//- (NSData *)lt_aes256DecryptWithKey:(NSString *)key;
- (NSData *)lt_aes256DecryptWithKeyBytes:(const void *)key;
@end
