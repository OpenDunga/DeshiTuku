//
//  DTProfileInputViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTProfileInputViewController.h"
#import "DTUserManager.h"

@interface DTProfileInputViewController ()

@end

@implementation DTProfileInputViewController

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
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onNextPressed:(id)sender {
    DTUserManager *manager = [DTUserManager sharedManager];
    [manager registerUser:manager.currentUser success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    }];
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    NSString *text = textView.text;
    DTUserManager *manager = [DTUserManager sharedManager];
    DTUser *user = [manager currentUser];
    user.profile = text;
}

@end
