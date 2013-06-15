//
//  DTProfileInputViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTProfileInputViewController : UIViewController <UITextViewDelegate>
- (IBAction)onNextPressed:(id)sender;

@property(readwrite, nonatomic) IBOutlet UITextView *textView;
@property(readwrite, nonatomic) IBOutlet UIButton *button;

@end
