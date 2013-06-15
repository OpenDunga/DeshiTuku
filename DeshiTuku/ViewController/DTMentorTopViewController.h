//
//  DTMentorTopViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/16.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface DTMentorTopViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (readwrite, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic) NSArray *disciples;

@end
