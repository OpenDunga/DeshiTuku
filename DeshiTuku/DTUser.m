//
//  DTUser.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTUser.h"

@implementation DTUser

#pragma mark NSCoding

- (id)init {
    self = [super init];
    if (self) {
        self.profile = @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder {
    [coder encodeInteger:self.age forKey:@"age"];
    [coder encodeObject:self.userID forKey:@"userID"];
    // ToDo 画像のNSData化
    NSData *data = UIImagePNGRepresentation(self.signature);
    [coder encodeObject:data forKey:@"signature"];
    [coder encodeObject:self.profile forKey:@"profile"];
    [coder encodeInteger:self.topicID forKey:@"topicID"];
    [coder encodeObject:self.topicName forKey:@"topicName"];
    [coder encodeInteger:(int)self.type forKey:@"type"];
}
- (id)initWithCoder:(NSCoder*)decoder {
    self = [super init];
    if (self) {
        self.age = [decoder decodeIntegerForKey:@"age"];
        self.userID = [decoder decodeObjectForKey:@"userID"];
        NSData *data = [decoder decodeObjectForKey:@"signature"];
        self.signature = [UIImage imageWithData:data];
        self.profile = [decoder decodeObjectForKey:@"profile"];
        self.topicID = [decoder decodeIntegerForKey:@"topicID"];
        self.topicName = [decoder decodeObjectForKey:@"topicName"];
        self.type = (NSInteger)[decoder decodeIntegerForKey:@"type"];
    }
    return self;
}

- (NSString *) sinatureBytes {
    NSData *data = UIImagePNGRepresentation(self.signature);
    return [self stringWithBytes:data];
}

- (NSString*) stringWithBytes:(NSData *)data {
    NSMutableString *stringBuffer = [NSMutableString
                                     stringWithCapacity:([data length] * 2)];
    const unsigned char *dataBuffer = [data bytes];
    int i;
    
    for (i = 0; i < [data length]; ++i) {
        [stringBuffer appendFormat:@"%02lX", (unsigned long)dataBuffer[ i ]];
    }
    return stringBuffer;
}

@end
