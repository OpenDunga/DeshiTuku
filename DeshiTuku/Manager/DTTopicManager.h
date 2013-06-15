//
//  DTTopicManager.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTopicManager : NSObject

+ (id)sharedManager;
- (void)fetchTopicList;

@property(readwrite, nonatomic) NSMutableArray *topics;

@end
