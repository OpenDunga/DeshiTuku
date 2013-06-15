//
//  DTMentorApplyViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/16.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTMentorApplyViewController.h"

@interface DTMentorApplyViewController ()

@end

@implementation DTMentorApplyViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImageView *signatureView = (UIImageView *)[self.view viewWithTag:1];
    UIImageView *titleView = (UIImageView *)[self.view viewWithTag:2];
    UILabel *ageLabel = (UILabel *)[self.view viewWithTag:3];
    UILabel *profileLabel = (UILabel *)[self.view viewWithTag:4];
    
    signatureView.image = self.mentor.signature;
    titleView.image = self.mentor.titleImage;
    ageLabel.text = [NSString stringWithFormat:@"%d", self.mentor.age];
    profileLabel.text = self.mentor.profile;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onApplyButtonPressed:(id)sender {
    DTUserManager *manager = [DTUserManager sharedManager];
    [manager applyMentor:self.mentor
                disciple:[manager currentUser]
                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                     [self.navigationController popViewControllerAnimated:YES];
                 }];
}

- (void)onBackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
