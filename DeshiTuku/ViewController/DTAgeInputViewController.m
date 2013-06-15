//
//  DTAgeInputViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTAgeInputViewController.h"
#import "DTUserManager.h"
#import "DTTopicManager.h"

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
    [[DTTopicManager sharedManager] fetchTopicList];
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
    NSError *error = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]+$" options:0 error:&error];
    NSArray *arr = [regexp matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if ([string length] > 0 && [arr count] == 0) {
        return NO;
    }
    
    BOOL result = YES;
    
    // 例えば文字数を 30 文字に制限します。
    NSUInteger maxLength = 3;
    // iPhone の Return キーが押された場合は "\n" が渡されてくるところに注意します。
    if ([string compare:@"\n"] == 0) {
        // Return キーが押された場合は、文字数に限らず、それを受け入れるようにしておきます。
        result = YES;
    } else {
        // Return キーではない場合には、最大文字数を超えないときだけ、受け入れるようにします。
        NSUInteger textLength = textField.text.length;
        NSUInteger rangeLength = range.length;
        NSUInteger stringLength = string.length;
        NSUInteger length = textLength - rangeLength + stringLength;
        result = (length <= maxLength);
    }
    return result;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // ToDo 数字チェック
    NSString *ageString = textField.text;
    NSError *error = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]+$" options:0 error:&error];
    NSArray *arr = [regexp matchesInString:ageString options:0 range:NSMakeRange(0, ageString.length)];
    if ([arr count] > 0) {
        int age = [ageString integerValue];
        DTUser *user = [[DTUserManager sharedManager] currentUser];
        user.age = age;
        if (age >= 50) { // 先生
            user.type = DTUserTypeMentor;
            [self performSegueWithIdentifier:@"DTMentorSegue" sender:self];
        } else {
            user.type = DTUserTypeDisciple;
            [self performSegueWithIdentifier:@"DTDiscipleSegue" sender:self];
        }
        return YES;
    }
    return NO;
}

@end
