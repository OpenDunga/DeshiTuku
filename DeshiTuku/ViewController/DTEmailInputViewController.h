//
//  DTEmailInputViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTEmailInputViewController : UIViewController <UITextFieldDelegate>

- (IBAction)nextButtonPressed:(id)sender;
@property (readwrite, nonatomic) IBOutlet UITextField *textField;

@end
