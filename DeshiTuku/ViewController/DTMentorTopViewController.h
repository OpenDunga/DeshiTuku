//
//  DTMentorTopViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/16.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTMentorTopViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (readwrite, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic) NSArray *disciples;

@end
