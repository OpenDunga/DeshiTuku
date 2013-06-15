//
//  DTAgeInputViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTAgeInputViewController.h"
#import "DTUserManager.h"

@interface DTAgeInputViewController ()

@end

@implementation DTAgeInputViewController

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
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.textField becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //NSInteger age = [string integerValue];
    _ageLabel.text = string;
    if ([string isEqualToString:@"\n"]) {
	[textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // ToDo 数字チェック
    NSString *ageString = self.ageLabel.text;
    NSError *error = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]+$" options:0 error:&error];
    NSArray *arr = [regexp matchesInString:ageString options:0 range:NSMakeRange(0, ageString.length)];
    if ([arr count] > 0) {
        int age = [ageString integerValue];
        DTUser *user = [[DTUserManager sharedManager] currentUser];
        user.age = age;
        [self performSegueWithIdentifier:@"DTSignatureInputSegue" sender:self];
        return YES;
    }
    return NO;
}

@end
