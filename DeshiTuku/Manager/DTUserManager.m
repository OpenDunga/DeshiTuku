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

- (DTUser *)currentUser {
    NSUserDefaults *dt = [NSUserDefaults standardUserDefaults];
    DTUser *user = (DTUser *)[dt objectForKey:kCurrentUserKey];
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
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"/mentor_entry.php"
                                                      parameters:@{@"age" : [NSNumber numberWithInt:user.age],
                                    @"profile" : user.profile,
                                    @"topic_id" : [NSNumber numberWithInt:user.topicID]}];

    NSLog(@"age = %d", user.age);
    
    NSLog(@"topic = %d", user.topicID);
    
    NSLog(@"profile = %@", user.profile);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    /*
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:(NSURLRequest *)
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"fail");
                                                                                        }];*/
}

@end
