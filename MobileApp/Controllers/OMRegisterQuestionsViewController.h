//
//  OMRegisterQuestionsViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/18/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMShowRegisteredQuestionsViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface OMRegisterQuestionsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, FinishedRegisteringQuestionsDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) id<FinishedRegisteringQuestionsDelegate> delegate;

- (IBAction)btnAcceptAnswer:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblQuestions;

@property (weak, nonatomic) IBOutlet UITextField *txtAnswer;

- (IBAction)confirmTextChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtConfirmAnswer;

@property (weak, nonatomic) IBOutlet UIImageView *imageSteps;

- (IBAction)answerTextChanged:(id)sender;


@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *myScrollView;

@end
