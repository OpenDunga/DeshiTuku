//
//  DTUser.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTUser.h"
#import "UIImage+UIImage_HexString.h"

@implementation DTUser

#pragma mark NSCoding

+ (DTUser *)userWithDictionary:(NSDictionary *)dict {
    DTUser *user = [[DTUser alloc] init];
    user.primaryKey = [dict[@"pk"] intValue];
    user.topicName = dict[@"topic"];
    user.age = [dict[@"age"] intValue];
    user.profile = dict[@"profile"];
    user.averageAge = [dict[@"age_ave"] intValue];
    user.title = dict[@"title"];
    user.signature = [UIImage imageWithHexString:dict[@"signature"]];
    return user;
}

- (id)init {
    self = [super init];
    if (self) {
        self.profile = @"";
        self.email = @"";
        self.title = @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder {
    [coder encodeInteger:self.primaryKey forKey:@"primaryKey"];
    [coder encodeInteger:self.age forKey:@"age"];
    [coder encodeInteger:self.averageAge forKey:@"averageAge"];
    [coder encodeBool:self.isMentor forKey:@"isMentor"];
    [coder encodeInteger:self.likes forKey:@"likes"];
    [coder encodeObject:self.userID forKey:@"userID"];
    [coder encodeObject:self.email forKey:@"email"];
    // ToDo 画像のNSData化
    NSData *data = UIImagePNGRepresentation(self.signature);
    [coder encodeObject:data forKey:@"signature"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.profile forKey:@"profile"];
    [coder encodeInteger:self.topicID forKey:@"topicID"];
    [coder encodeObject:self.topicName forKey:@"topicName"];
    [coder encodeInteger:(int)self.type forKey:@"type"];
}
- (id)initWithCoder:(NSCoder*)decoder {
    self = [super init];
    if (self) {
        self.primaryKey = [decoder decodeIntegerForKey:@"primaryKey"];
        self.age = [decoder decodeIntegerForKey:@"age"];
        self.likes = [decoder decodeIntegerForKey:@"likes"];
        self.averageAge = [decoder decodeIntegerForKey:@"averageAge"];
        self.isMentor = [decoder decodeBoolForKey:@"isMentor"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.userID = [decoder decodeObjectForKey:@"userID"];
        NSData *data = [decoder decodeObjectForKey:@"signature"];
        self.signature = [UIImage imageWithData:data];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.profile = [decoder decodeObjectForKey:@"profile"];
        self.topicID = [decoder decodeIntegerForKey:@"topicID"];
        self.topicName = [decoder decodeObjectForKey:@"topicName"];
        self.type = (NSInteger)[decoder decodeIntegerForKey:@"type"];
    }
    return self;
}

- (NSString *) signatureBytes {
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

- (UIImage *)titleImage {
    NSArray *names = @[@"センセイ", @"シショウ", @"メイジン", @"タツジン", @"センセイマスター"];
    if ([names containsObject:self.title]) {
        int index = [names indexOfObject:self.title];
        NSString *imageName = [NSString stringWithFormat:@"rank%d.png", index];
        return [UIImage imageNamed:imageName];
    }
    NSString *imageName = @"rank0.png";
    return [UIImage imageNamed:imageName];
}

@end
