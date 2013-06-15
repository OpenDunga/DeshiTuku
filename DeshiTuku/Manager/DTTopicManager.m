//
//  DTTopicManager.m
//  ;;
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTTopicManager.h"
#import "AFNetworking.h"

@implementation DTTopicManager

const NSString *kTopicListURL = @"http://deshitsuku.dotdister.net/";

+ (id)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.topics = [NSMutableArray array];
    }
    return self;
}

- (void)fetchTopicList {
    NSURL *url = [NSURL URLWithString:@"http://deshitsuku.dotdister.net/topics.php?list=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSArray *array = (NSArray *)JSON;
                                                                                            for (NSDictionary *dict in array) {
                                                                                                [self.topics addObject:dict];
                                                                                            }
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"fail");
                                                                                        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

@end
