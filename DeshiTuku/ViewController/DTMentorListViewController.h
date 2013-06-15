//
//  DTMentorListViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTMentorListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(readwrite, nonatomic) IBOutlet UITableView *tableView;

@end
