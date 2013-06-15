//
//  UIImage+UIImage_HexString.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "UIImage+UIImage_HexString.h"

@implementation UIImage (UIImage_HexString)

+ (UIImage *)imageWithHexString:(NSString *)hex {
    NSString* command = [hex stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (int i = 0; i < [command length] / 2; i++) {
        byte_chars[0] = [command characterAtIndex:i*2];
        byte_chars[1] = [command characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    UIImage *image = [UIImage imageWithData:commandToSend];
    return image;
}

@end
