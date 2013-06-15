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
    [[DTUserManager sharedManager] fetchMentorList];
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
        [self performSegueWithIdentifier:@"DTMentorTopSegue" sender:self];
    } else if (user.type == DTUserTypeDisciple) {
        [self performSegueWithIdentifier:@"DTMenterListSegue" sender:self];
    }
}

- (void)onResetButtonPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"データの削除"
                                                        message:@"端末に保存されているデータを削除します。よろしいですか。"
                                                       delegate:self cancelButtonTitle:@"キャンセル"
                                              otherButtonTitles:@"削除", nil];
    [alertView show];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
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
    if (user == nil) {
        [self.resetButton setHidden:YES];
    }
}

@end
