//
//  NSData+LTInputAES.m
//  LTInputView
//
//  Created by yelon on 2018/12/4.
//

#import "NSData+LTInputAES.h"
#import <CommonCrypto/CommonCryptor.h>

NSString *LTInput_FilterString(id obj){
    
    if (obj == nil) {
        
        return @"";
    }
    
    if ([obj isKindOfClass:[NSString class]]) {
        
        return [NSString stringWithFormat:@"%@",obj];
        
    }else if([obj isKindOfClass:[NSNumber class]]){
        
        return [NSString stringWithFormat:@"%@",obj];
    }
    return @"";
    
}

@implementation NSData (LTInputAES)

+ (NSData *)randomBytes:(const int)size{
    
    uint8_t randomBytes[size];
    int result = SecRandomCopyBytes(kSecRandomDefault, size, randomBytes);
    if (result == errSecSuccess) {
        
        NSData *randomData = [[NSData alloc] initWithBytes:randomBytes length:size];
        return randomData;
    } else {
        return nil;
    }
}

- (NSData *)lt_aes256EncryptWithKey:(NSString *)key {
    
    if (!self) {
        
        return nil;
    }
    
    key = LTInput_FilterString(key);
    
    if (key.length == 0) {
        
        return nil;
    }
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    return [self lt_aes256EncryptWithKeyBytes:keyPtr];
}

- (NSData *)lt_aes256EncryptWithKeyBytes:(const void *)key {
    
    if (!self) {
        
        return nil;
    }
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          key, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
        free(buffer);
        return resultData;
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)lt_aes256DecryptWithKey:(NSString *)key {
    
    if (!self) {
        
        return nil;
    }
    
    key = LTInput_FilterString(key);
    
    if (key.length == 0) {
        
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    return [self lt_aes256DecryptWithKeyBytes:keyPtr];
}

- (NSData *)lt_aes256DecryptWithKeyBytes:(const void *)key {
    
    if (!self) {
        
        return nil;
    }
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          key, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        NSData *resultData = [NSData dataWithBytes:buffer length:numBytesDecrypted];
        free(buffer);
        return resultData;
    }
    
    free(buffer);
    return nil;
}
@end
