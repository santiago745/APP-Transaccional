//
//  IGRestorePassViewController.h
//  MobileApp
//
//  Created by steven muñoz on 11/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@protocol ForgotPasswordDelegate<NSObject>


@required

-(void) forgotPassFinished;

@end

@interface IGRestorePassViewController : UIViewController <ForgotPasswordDelegate, UIAlertViewDelegate, UITextFieldDelegate, UITextViewDelegate>

- (IBAction)pickDocument:(id)sender;

- (IBAction)pickDate:(id)sender;

@property (nonatomic, weak) id<ForgotPasswordDelegate> delegate;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *txtDocumentType;

@property (weak, nonatomic) IBOutlet UITextField *txtDocumentNumber;

- (IBAction)sendData:(id)sender;


@end
