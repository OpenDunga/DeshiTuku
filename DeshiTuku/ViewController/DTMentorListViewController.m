//
//  DTMentorListViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTMentorListViewController.h"
#import "DTMentorApplyViewController.h"
#import "DTUserManager.h"

@interface DTMentorListViewController ()

@end

@implementation DTMentorListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DTUserManager sharedManager] mentors] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MentorCell"];
    DTUser *user = [[[DTUserManager sharedManager] mentors] objectAtIndex:indexPath.row];
    UIImageView *signatureView = (UIImageView *)[cell viewWithTag:1];
    UIImageView *titleView = (UIImageView *)[cell viewWithTag:2];
    UILabel *ageLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *profileLabel = (UILabel *)[cell viewWithTag:4];
    
    [signatureView setImage:user.signature];
    [ageLabel setText:[NSString stringWithFormat:@"%d", user.age]];
    [profileLabel setText:user.profile];
    profileLabel.text = user.profile;
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DTUser *user = [[[DTUserManager sharedManager] mentors] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"DTMentorApply" sender:user];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DTMentorApplyViewController *apply = [segue destinationViewController];
    apply.mentor = sender;
}

@end
