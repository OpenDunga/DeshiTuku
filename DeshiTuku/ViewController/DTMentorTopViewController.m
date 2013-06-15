//
//  DTMentorTopViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/16.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTMentorTopViewController.h"
#import "DTUserManager.h"

@interface DTMentorTopViewController ()

@end

@implementation DTMentorTopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DTUserManager *manager = [DTUserManager sharedManager];
    [manager fetchDisciplesList:[manager currentUser] success:^(NSArray *disciples) {
        self.disciples = disciples;
        [self.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIImageView *signatureView = (UIImageView *)[self.view viewWithTag:1];
    UIImageView *titleView = (UIImageView *)[self.view viewWithTag:2];
    UILabel *ageLabel = (UILabel *)[self.view viewWithTag:3];
    UILabel *profileLabel = (UILabel *)[self.view viewWithTag:4];
    
    DTUserManager *manager = [DTUserManager sharedManager];
    DTUser *user = manager.currentUser;
    signatureView.image = user.signature;
    titleView.image = user.titleImage;
    ageLabel.text = [NSString stringWithFormat:@"%d", user.age];
    profileLabel.text = user.profile;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.disciples == nil) {
        return 0;
    }
    return [self.disciples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTUser *user = [self.disciples objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscipleCell"];
    UIImageView *signatureView = (UIImageView *)[cell viewWithTag:1];
    UILabel *likeLabel = (UILabel *)[cell viewWithTag:2];
    signatureView.image = user.signature;
    likeLabel.text = [NSString stringWithFormat:@"%d", user.likes];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DTUser *user = [self.disciples objectAtIndex:indexPath.row];
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    // メール本文を設定
    [mailPicker setMessageBody:@"本文" isHTML:NO];
    
    // 題名を設定
    [mailPicker setSubject:@"題名"];
    
    // 宛先を設定
    [mailPicker setToRecipients:@[user.email]];
    [self presentModalViewController:mailPicker animated:YES];
}

#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}

@end
