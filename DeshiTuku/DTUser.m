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

- (void)encodeWithCoder:(NSCoder*)coder {
    [coder encodeInteger:self.age forKey:@"age"];
    [coder encodeObject:self.userID forKey:@"userID"];
    // ToDo 画像のNSData化
    //[coder encodeObject:self.signiture forKey:<#(NSString *)key#>];
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
        self.profile = [decoder decodeObjectForKey:@"profile"];
        self.topicID = [decoder decodeIntegerForKey:@"topicID"];
        self.topicName = [decoder decodeObjectForKey:@"topicName"];
        self.type = (NSInteger)[decoder decodeIntegerForKey:@"type"];
    }
    return self;
}

@end
