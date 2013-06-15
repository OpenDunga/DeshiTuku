//
//  DTEmailInputViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTEmailInputViewController.h"
#import "DTUserManager.h"

@interface DTEmailInputViewController ()

@end

@implementation DTEmailInputViewController

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
    [self.textField becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextButtonPressed:(id)sender {
    DTUserManager *manager = [DTUserManager sharedManager];
    [manager registerUser:manager.currentUser success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [manager fetchMentorList:manager.currentUser success:^(NSArray *mentors) {
            [self performSegueWithIdentifier:@"DTDiscipleRegisterSegue" sender:self];
        }];
    }];
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    DTUserManager *manager = [DTUserManager sharedManager];
    manager.currentUser.email = textField.text;
    return YES;
}

@end
