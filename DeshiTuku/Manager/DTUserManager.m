//
//  DTUserManager.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTUserManager.h"

static NSString *kCurrentUserKey = @"myAccount";

@implementation DTUserManager

+ (id)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (DTUser *)currentUser {
    NSUserDefaults *dt = [NSUserDefaults standardUserDefaults];
    DTUser *user = (DTUser *)[dt objectForKey:kCurrentUserKey];
    if (user != nil) {
        return user;
    }
    DTUser *newUser = [[DTUser alloc] init];
    return newUser;
}

@end
