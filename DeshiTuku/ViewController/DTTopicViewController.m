//
//  DTTopicViewController.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTTopicViewController.h"
#import "DTTopicManager.h"
#import "DTUserManager.h"

@interface DTTopicViewController ()

@end

@implementation DTTopicViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [[[DTTopicManager sharedManager] topics] objectAtIndex:indexPath.row];
    int pk = [[dict objectForKey:@"pk"] intValue];
    NSString *name = [dict objectForKey:@"name"];
    DTUser *user = [[DTUserManager sharedManager] currentUser];
    user.topicID = pk;
    user.topicName = name;
    [self performSegueWithIdentifier:@"DTProfileInputSegue" sender:self];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DTTopicManager sharedManager] topics] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSDictionary *dict = [[[DTTopicManager sharedManager] topics] objectAtIndex:indexPath.row];
        NSString *pk = [NSString stringWithFormat:@"%d", [[dict objectForKey:@"pk"] intValue]];
        NSString *name = [dict objectForKey:@"name"];
        cell.textLabel.text = name;
    }
    return cell;
}

@end
