//
//  DTMentorApplyViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/16.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTUserManager.h"

@interface DTMentorApplyViewController : UIViewController

@property(readwrite, nonatomic) DTUser *mentor;
@property(readwrite, nonatomic) IBOutlet UIButton *applyButton;
@property(readwrite, nonatomic) IBOutlet UIButton *thanksButton;

- (IBAction)onApplyButtonPressed:(id)sender;
- (IBAction)onThankButtonPressed:(id)sender;
- (IBAction)onBackButtonPressed:(id)sender;

@end
