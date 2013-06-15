//
//  DTUser.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DTUserTypeMentor,
    DTUserTypeDisciple
} DTUserType;

@interface DTUser : NSObject <NSCoding>

- (NSString *)sinatureBytes;
- (UIImage *)titleImage;
+ (DTUser *)userWithDictionary:(NSDictionary *)dict;

@property(readwrite) NSInteger primaryKey;
@property(readwrite) NSInteger age;
@property(readwrite) NSInteger likes;
@property(readwrite) NSInteger averageAge;
@property(readwrite) NSString *userID;
@property(readwrite) NSString *email;
@property(readwrite, copy) NSString *title;
@property(readwrite, copy) UIImage *signature;
@property(readwrite, copy) NSString *profile;
@property(readwrite) NSInteger topicID;
@property(readwrite, copy) NSString *topicName;
@property(readwrite) DTUserType type;

@end
