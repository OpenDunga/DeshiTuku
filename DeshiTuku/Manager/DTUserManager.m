//
//  DTUserManager.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTUserManager.h"
#import "AFNetworking.h"

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

- (DTUser *)loadUser {
    NSUserDefaults *dt = [NSUserDefaults standardUserDefaults];
    NSData *data = [dt objectForKey:kCurrentUserKey];
    if (data != nil) {
        DTUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return user;
    }
    return nil;
}

- (DTUser *)currentUser {
    DTUser *user = [self loadUser];
    if (user != nil) {
        return user;
    }
    if (_currentUser == nil) {
        _currentUser = [[DTUser alloc] init];
    }
    return _currentUser;
}

- (void)registerUser:(DTUser *)user {
    NSURL *url = [NSURL URLWithString:@"http://deshitsuku.dotdister.net/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request;
    if (user.type == DTUserTypeMentor) {
        request = [httpClient requestWithMethod:@"POST"
                                           path:@"/mentor_entry.php"
                                     parameters:@{@"age" : [NSNumber numberWithInt:user.age],
                   @"profile" : user.profile,
                   @"topic_id" : [NSNumber numberWithInt:user.topicID],
                   @"signature" : [user sinatureBytes]}];
    } else {
        request = [httpClient requestWithMethod:@"POST"
                                           path:@"/disciple_entry.php"
                                     parameters:@{@"age" : [NSNumber numberWithInt:user.age],
                   @"email" : user.email,
                   @"signature" : [user sinatureBytes]}];
        
    }
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSString *uid = ((NSDictionary*)JSON)[@"uid"];
                                                                                            user.userID = uid;
                                                                                            NSLog(@"uid = %@", user.userID);
                                                                                            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                                                                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                                                                                            [ud setObject:data forKey:kCurrentUserKey];
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"failed");
                                                                                        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)resetUser {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:kCurrentUserKey];
}

@end
