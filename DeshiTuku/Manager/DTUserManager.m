//
//  DTUserManager.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTUserManager.h"
#import "AFNetworking.h"
#import "UIImage+UIImage_HexString.h"

static NSString *kCurrentUserKey = @"myAccount";
static NSString *baseURL = @"http://deshitsuku.dotdister.net/";

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

- (void)registerUser:(DTUser *)user success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, id))success {
    NSURL *url = [NSURL URLWithString:(NSString *)baseURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request;
    if (user.type == DTUserTypeMentor) {
        request = [httpClient requestWithMethod:@"POST"
                                           path:@"/mentor_entry.php"
                                     parameters:@{@"age" : [NSNumber numberWithInt:user.age],
                   @"profile" : user.profile,
                   @"topic_id" : [NSNumber numberWithInt:user.topicID],
                   @"signature" : [user signatureBytes]}];
    } else {
        request = [httpClient requestWithMethod:@"POST"
                                           path:@"/disciple_entry.php"
                                     parameters:@{@"age" : [NSNumber numberWithInt:user.age],
                   @"email" : user.email,
                   @"signature" : [user signatureBytes]}];
        
    }
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSString *uid = ((NSDictionary*)JSON)[@"uid"];
                                                                                            NSInteger primaryKey = [((NSDictionary *)JSON)[@"pk"] intValue];
                                                                                            user.userID = uid;
                                                                                            user.primaryKey = primaryKey;
                                                                                            NSLog(@"uid = %@, pk = %d", user.userID, user.primaryKey);
                                                                                            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                                                                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                                                                                            [ud setObject:data forKey:kCurrentUserKey];
                                                                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                                                                            success(request, response, JSON);
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"failed");
                                                                                        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)applyMentor:(DTUser *)mentor disciple:(DTUser *)disciple success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, id))success {
    NSURL *url = [NSURL URLWithString:(NSString *)baseURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                     path:@"disciple_apply.php"
                                               parameters:@{@"disciple_uid" : disciple.userID,
                             @"mentor_pk" : [NSNumber numberWithInt:mentor.primaryKey]}];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"success");
                                                                                            mentor.isMentor = YES;
                                                                                            success(request, response, JSON);
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"fail");
                                                                                        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)resetUser {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:kCurrentUserKey];
    _currentUser = nil;
}

- (void)fetchMentorList:(DTUser *)disciple {
    NSURL *url = [NSURL URLWithString:(NSString *)baseURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                     path:@"mentors.php"
                                               parameters:@{@"disciple_pk" : [NSNumber numberWithInt:disciple.primaryKey]}];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSMutableArray *mentors = [NSMutableArray array];
                                                                                            for (NSDictionary *dict in JSON) {
                                                                                                DTUser *user = [DTUser userWithDictionary:dict];
                                                                                                user.isMentor = [[dict objectForKey:@"is_mentor"] boolValue];
                                                                                                [mentors addObject:user];
                                                                                            }
                                                                                            self.mentors = mentors;
    }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"fail");
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)fetchDisciplesList:(DTUser *)mentor success:(void (^)(NSArray *))success {
    NSURL *url = [NSURL URLWithString:(NSString *)baseURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                     path:@"disciples.php"
                                               parameters:@{@"uid" : mentor.userID}];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSMutableArray *disciples = [NSMutableArray array];
                                                                                            for (NSDictionary *dict in JSON) {
                                                                                                DTUser *user = [[DTUser alloc] init];
                                                                                                user.primaryKey = [dict[@"pk"] intValue];
                                                                                                user.age = [dict[@"age"] intValue];
                                                                                                user.signature = [UIImage imageWithHexString:dict[@"signature"]];
                                                                                                user.email = dict[@"email"];
                                                                                                user.likes = [dict[@"likes"] intValue];
                                                                                                [disciples addObject:user];
                                                                                            }
                                                                                            success(disciples);
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"fail");
                                                                                        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];    
}

- (void)thankMentor:(DTUser *)mentor from:(DTUser *)disciple success:(void (^)(DTUser *))success {
    NSURL *url = [NSURL URLWithString:(NSString *)baseURL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                     path:@"thanks.php"
                                               parameters:@{@"mentor_pk" : [NSNumber numberWithInt:mentor.primaryKey],
                             @"disciple_pk" : [NSNumber numberWithInt:disciple.primaryKey]}];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            mentor.likes += 1;
                                                                                            success(mentor);
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"fail");
                                                                                        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}

@end
