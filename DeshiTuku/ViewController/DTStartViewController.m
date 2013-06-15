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
    DTUser *user = [[DTUserManager sharedManager] loadUser];
    if (user.type == DTUserTypeDisciple) {
        [[DTUserManager sharedManager] fetchMentorList:user];
    }
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
    if (buttonIndex == 1) {
        [[DTUserManager sharedManager] resetUser];
        [self updateStartButton];
    }
}

#pragma mark private

- (void)updateStartButton {
    DTUser *user = [[DTUserManager sharedManager] loadUser];
    if (user == nil) {
        [self.startButton setImage:[UIImage imageNamed:@"title_start.png"] forState:UIControlStateNormal];
    } else {
        if (user.type == DTUserTypeMentor) {
            [self.startButton setImage:[UIImage imageNamed:@"title_mentor.png"] forState:UIControlStateNormal];
        } else if (user.type == DTUserTypeDisciple) {
            [self.startButton setImage:[UIImage imageNamed:@"title_disciple.png"] forState:UIControlStateNormal];
        }
    }
    if (user) {
        NSLog(@"pk = %d", user.primaryKey);
    }
    if (user == nil) {
        [self.resetButton setHidden:YES];
    }
}

@end
