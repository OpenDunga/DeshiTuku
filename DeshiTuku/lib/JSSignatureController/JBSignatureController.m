//
//  JBSignatureController.m
//  JBSignatureController
//
//  Created by Jesse Bunch on 12/10/11.
//  Copyright (c) 2011 Jesse Bunch. All rights reserved.
//

#import "JBSignatureController.h"
#import "JBSignatureView.h"
#import "DTSignatureInputDelegate.h"

#pragma mark - *** Private Interface ***

@interface JBSignatureController() {
@private
    __strong JBSignatureView *signatureView_;
    __strong UIImageView *signaturePanelBackgroundImageView_;
    __strong UIImage *portraitBackgroundImage_, *landscapeBackgroundImage_;
    __strong UIButton *confirmButton_, *cancelButton_;
    __strong id<JBSignatureControllerDelegate> delegate_;
}

// The view responsible for handling signature sketching
@property(nonatomic,strong) JBSignatureView *signatureView;

// The background image underneathe the sketch
@property(nonatomic,strong) UIImageView *signaturePanelBackgroundImageView;

// Private Methods
-(void)didTapCanfirmButton;
-(void)didTapCancelButton;

@end



@implementation JBSignatureController

@synthesize
signaturePanelBackgroundImageView = signaturePanelBackgroundImageView_,
signatureView = signatureView_,
portraitBackgroundImage = portraitBackgroundImage_,
landscapeBackgroundImage = landscapeBackgroundImage_,
confirmButton = confirmButton_,
cancelButton = cancelButton_,
delegate = delegate_;



#pragma mark - *** Initializers ***

/**
 * Designated initializer
 * @author Jesse Bunch
 **/
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    
    return self;
    
}

/**
 * Initializer
 * @author Jesse Bunch
 **/
-(id)init {
    return [self initWithNibName:nil bundle:nil];
}




#pragma mark - *** View Lifecycle ***

/**
 * Since we're not using a nib. We need to load our views manually.
 * @author Jesse Bunch
 **/
-(void)loadView {
    [super loadView];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.delegate = [[DTSignatureInputDelegate alloc] init];
    
    // Background images
    self.portraitBackgroundImage = [UIImage imageNamed:@"name_input"];
    //self.landscapeBackgroundImage = [UIImage imageNamed:@"bg-signature-landscape"];
    self.signaturePanelBackgroundImageView = [[UIImageView alloc] initWithImage:self.portraitBackgroundImage];
    
    // Signature view
    self.signatureView = [[JBSignatureView alloc] init];
    self.signatureView.backgroundColor = [UIColor clearColor];
    
    // Confirm
    /*self.confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [self.confirmButton sizeToFit];
    [self.confirmButton setFrame:CGRectMake(self.view.frame.size.width - self.confirmButton.frame.size.width - 10.0f,
                                            10.0f,
                                            self.confirmButton.frame.size.width,
                                            self.confirmButton.frame.size.height)];
    [self.confirmButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];*/
    
    // Cancel
    /*self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton sizeToFit];
    [self.cancelButton setFrame:CGRectMake(10.0f,
                                           10.0f,
                                           self.cancelButton.frame.size.width,
                                           self.cancelButton.frame.size.height)];
    [self.cancelButton setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];*/
    
}

/**
 * Setup the view heirarchy
 * @author Jesse Bunch
 **/
-(void)viewDidLoad {
    [super viewDidLoad];
    
    // Background Image
    UIImage *background = [UIImage imageNamed:@"back_scroll.png"];
    UIImageView *view = [[UIImageView alloc] initWithImage:background];
    [view setFrame:self.view.bounds];
    [self.view addSubview:view];
    
    // Background Image
    [self.signaturePanelBackgroundImageView setFrame:CGRectMake(119, 142, 544, 200)];
    [self.signaturePanelBackgroundImageView setContentMode:UIViewContentModeTopLeft];
    [self.view addSubview:self.signaturePanelBackgroundImageView];
    
    // Signature View
    [self.signatureView setFrame:CGRectMake(119, 142, 544, 200)];
    [self.view addSubview:self.signatureView];
    
    UIImageView *caption = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name_caption"]];
    [caption setFrame:CGRectMake(130, 77, 546, 62)];
    [self.view addSubview:caption];
    
    [self.nextButton removeFromSuperview];
    [self.view addSubview:self.nextButton];
    [self.nextButton setFrame:CGRectMake(449, 415, 188, 193)];
    
    [self.clearButton removeFromSuperview];
    [self.view addSubview:self.clearButton];
    [self.clearButton setFrame:CGRectMake(144, 415, 188, 193)];
    
    // Buttons
    //[self.view addSubview:self.cancelButton];
    //[self.view addSubview:self.confirmButton];
    
    // Button actions
    //[self.confirmButton addTarget:self action:@selector(didTapCanfirmButton) forControlEvents:UIControlEventTouchUpInside];
    //[self.cancelButton addTarget:self action:@selector(didTapCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
}

- (IBAction)nextButtonPressed:(id)sender {
    [self didTapCanfirmButton];
}

/**
 * Support for different orientations
 * @author Jesse Bunch
 **/
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

/**
 * Upon rotation, switch out the background image
 * @author Jesse Bunch
 **/
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self.signaturePanelBackgroundImageView setImage:self.landscapeBackgroundImage];
    } else {
        [self.signaturePanelBackgroundImageView setImage:self.portraitBackgroundImage];
    }
    
}

/**
 * After rotation, we need to adjust the signature view's frame to fill.
 * @author Jesse Bunch
 **/
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.signatureView setFrame:self.view.bounds];
    [self.signatureView setNeedsDisplay];
}


#pragma mark - *** Actions ***

/**
 * Upon confirmation, message the delegate with the image of the signature.
 * @author Jesse Bunch
 **/
-(void)didTapCanfirmButton {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(signatureConfirmed:signatureController:)]) {
        UIImage *signatureImage = [self.signatureView getSignatureImage];
        [self.delegate signatureConfirmed:signatureImage signatureController:self];
    }
    
}

/**
 * Upon cancellation, message the delegate.
 * @author Jesse Bunch
 **/
-(void)didTapCancelButton {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(signatureCancelled:)]) {
        [self.delegate signatureCancelled:self];
    }
    
}

#pragma mark - *** Public Methods ***

/**
 * Clears the signature from the signature view. If the delegate is subscribed,
 * this method also messages the delegate with the image before it's cleared.
 * @author Jesse Bunch
 **/
-(void)clearSignature {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(signatureCleared:signatureController:)]) {
        UIImage *signatureImage = [self.signatureView getSignatureImage];
        [self.delegate signatureCleared:signatureImage signatureController:self];
    }
    
    [self.signatureView clearSignature];
}

- (IBAction)clearButtonPressed:(id)sender {
    [self clearSignature];
}


@end
