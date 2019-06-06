//
//  IGRestorePassQuestionsViewController.h
//  MobileApp
//
//  Created by steven muñoz on 31/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGRestorePassViewController.h"

@interface IGRestorePassQuestionsViewController : UIViewController<ForgotPasswordDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) id<ForgotPasswordDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblFirstQuestion;

@property (weak, nonatomic) IBOutlet UILabel *lblSecondQuestion;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstQuestion;

@property (weak, nonatomic) IBOutlet UITextField *txtSecondQuestion;

@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

- (IBAction)nextAction:(id)sender;


@end
