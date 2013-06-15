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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIImageView *signatureView = (UIImageView *)[self.view viewWithTag:1];
    UIImageView *titleView = (UIImageView *)[self.view viewWithTag:2];
    UILabel *ageLabel = (UILabel *)[self.view viewWithTag:3];
    UILabel *profileLabel = (UILabel *)[self.view viewWithTag:4];
    
    DTUserManager *manager = [DTUserManager sharedManager];
    DTUser *user = manager.currentUser;
    NSLog(@"%@", ageLabel);
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

@end
