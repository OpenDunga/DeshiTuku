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
    [coder encodeObject:self.topic forKey:@"topic"];
    [coder encodeInteger:(int)self.type forKey:@"type"];
}
- (id)initWithCoder:(NSCoder*)decoder {
    self = [super init];
    if (self) {
        self.age = [decoder decodeIntegerForKey:@"age"];
        self.userID = [decoder decodeObjectForKey:@"userID"];
        self.profile = [decoder decodeObjectForKey:@"profile"];
        self.topic = [decoder decodeObjectForKey:@"topic"];
        self.type = (NSInteger)[decoder decodeIntegerForKey:@"type"];
    }
    return self;
}

@end
