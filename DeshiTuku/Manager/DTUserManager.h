//
//  DTUserManager.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTUser.h"

@interface DTUserManager : NSObject {
    DTUser *_currentUser;
}

+ (id)sharedManager;
- (DTUser *)currentUser;

@end
