//
//  DTStartViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTStartViewController.h"
#import "DTUserManager.h"

@interface DTStartViewController ()

@end

@implementation DTStartViewController

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
    [self updateStartButton];
    [[DTUserManager sharedManager] fetchMenterList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onStartButtonPressed:(id)sender {
    DTUser *user = [[DTUserManager sharedManager] loadUser];
    if (user == nil) {
        [self performSegueWithIdentifier:@"DTInitializeSegue" sender:self];
    } else if (user.type == DTUserTypeMentor) {
    } else if (user.type == DTUserTypeDisciple) {
        [self performSegueWithIdentifier:@"DTMenterListSegue" sender:self];
    }
    
}

- (void)onResetButtonPressed:(id)sender {
    [[DTUserManager sharedManager] resetUser];
    [self updateStartButton];
}

#pragma mark private

- (void)updateStartButton {
    DTUser *user = [[DTUserManager sharedManager] loadUser];
    if (user == nil) {
        self.startButton.titleLabel.text = @"新規作成";
    } else if (user.type == DTUserTypeMentor) {
        self.startButton.titleLabel.text = @"弟子を取る";
    } else if (user.type == DTUserTypeDisciple) {
        self.startButton.titleLabel.text = @"教えを請う";
    }
}

@end
