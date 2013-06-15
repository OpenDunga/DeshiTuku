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

@property(readwrite) NSInteger age;
@property(readwrite) NSString *userID;
@property(readwrite, copy) UIImage *signiture;
@property(readwrite, copy) NSString *profile;
@property(readwrite, copy) NSString *topic;
@property(readwrite) DTUserType type;

@end
