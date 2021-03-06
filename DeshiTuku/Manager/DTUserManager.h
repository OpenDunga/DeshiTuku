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
- (DTUser *)loadUser;
- (void)registerUser:(DTUser *)user
             success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success;
- (void)resetUser;
- (void)applyMentor:(DTUser *)mentor
           disciple:(DTUser *)disciple
            success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success;
- (void)fetchMentorList:(DTUser *)disciple
                success:(void (^)(NSArray *mentors))success;
- (void)fetchDisciplesList:(DTUser *)mentor
                   success:(void (^)(NSArray *disciples))success;
- (void)thankMentor:(DTUser *)mentor from:(DTUser *)disciple
            success:(void (^)(DTUser *mentor))success;

@property (readwrite, nonatomic) NSArray *mentors ;

@end
