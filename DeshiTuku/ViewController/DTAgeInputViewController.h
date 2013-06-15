//
//  DTAgeInputViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTAgeInputViewController : UIViewController <UITextFieldDelegate>

@property(readwrite, nonatomic) IBOutlet UILabel *ageLabel;
@property(readwrite, nonatomic) IBOutlet UITextField *textField;

@end
