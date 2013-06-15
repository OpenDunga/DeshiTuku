//
//  DTUser.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTUser : NSObject

- (id)initWithUserName:(NSString*)username;

@property(readwrite) NSString* userName;

@end
