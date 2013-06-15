//
//  DTStartViewController.h
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTStartViewController : UIViewController

- (IBAction)onStartButtonPressed:(id)sender;
- (IBAction)onResetButtonPressed:(id)sender;

@property(readwrite, nonatomic) IBOutlet UIButton *startButton;

@end
