//
//  DTSignatureInputDelegate.m
//  DeshiTuku
//
//  Created by giginet on 2013/6/15.
//  Copyright (c) 2013 giginet. All rights reserved.
//

#import "DTSignatureInputDelegate.h"
#import "DTUserManager.h"

@implementation DTSignatureInputDelegate

#pragma mark DTSignatureViewDelegate

- (void)signatureConfirmed:(UIImage *)signatureImage signatureController:(JBSignatureController *)sender {
    DTUserManager *manager = [DTUserManager sharedManager];
    DTUser *user = [manager currentUser];
    user.signature = signatureImage;
    [sender performSegueWithIdentifier:@"DTTopicInputSegue" sender:self];
}

- (void)signatureCancelled:(JBSignatureController *)sender {
}

- (void)signatureCleared:(UIImage *)clearedSignatureImage signatureController:(JBSignatureController *)sender {
}


@end
