//
//  IGRestorePassQuestionsViewController.m
//  MobileApp
//
//  Created by steven muñoz on 31/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGRestorePassQuestionsViewController.h"
#import "IGQuestion.h"
#import "IGAnswer.h"
#import "IGMobileApp.h"
#import "IGForgotPasswordResponse.h"
#import "UITextField+IGValidateForms.h"

@interface IGRestorePassQuestionsViewController ()

@end

@implementation IGRestorePassQuestionsViewController
{
    NSMutableArray *userAnswers;
    IGQuestion *firstQuestion, *secondQuestion;
    IGAnswer *firstAnswer, *secondAnswer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userAnswers = [[NSMutableArray alloc]init];
    firstAnswer = [[IGAnswer alloc]init];
    secondAnswer = [[IGAnswer alloc]init];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    self.title = OM_TXT_RESTORE_PASSWORD;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
    [self setTexts:[[NSMutableArray alloc]initWithArray:[IGMobileApp sharedInstance].forgotPasswordResponse.pendingActionRequest.questions]];

}

-(void) setTexts:(NSMutableArray *)questions
{
    firstQuestion = [questions objectAtIndex:0];
    secondQuestion = [questions objectAtIndex:1];
    
    [self.btnContinue setTitle:OM_TXT_CLOSE forState:UIControlStateNormal] ;
    self.lblFirstQuestion.text = firstQuestion.text;
    self.lblSecondQuestion.text = secondQuestion.text;

}

- (NSString *)validateQuestions {
    
    NSString *errorMessage;
    NSString *validationRegex = IG_REGISTER_QUESTION_VALIDATION;
    
    if (![self.txtFirstQuestion isValidField]){
        errorMessage = OM_MESSAGE_REGISTERQUESTION_ANSWERREQUIRED;
        [self.txtFirstQuestion becomeFirstResponder];
    } else if (![self.txtSecondQuestion isValidField]){
        errorMessage = OM_MESSAGE_REGISTERQUESTION_ANSWERREQUIRED;
        [self.txtSecondQuestion becomeFirstResponder];
    } else if (![self.txtFirstQuestion isValidRegex:validationRegex]) {
        errorMessage = OM_MESSAGE_REGISTERQUESTION_VALIDATEREGEX;
        [self.txtFirstQuestion becomeFirstResponder];
    } else if (![self.txtSecondQuestion isValidRegex:validationRegex]) {
        errorMessage = OM_MESSAGE_REGISTERQUESTION_VALIDATEREGEX;
        [self.txtSecondQuestion becomeFirstResponder];
    }
    return errorMessage;
}


-(IBAction)backButtonPressed:(id)sender{
    [self displayCancelAlert];
}

-(void) displayCancelAlert
{
    UIAlertView *cancelQuestionsAlert = [[UIAlertView alloc] initWithTitle:OM_ALERT_REGISTERQUESTION_CANCELQUESTIONS_TITTLE message:OM_ALERT_REGISTERQUESTION_CANCELQUESTIONS_MESSAGE delegate:self cancelButtonTitle:OM_TXT_CANCEL otherButtonTitles:OM_TXT_ACCEPT, nil];
    
    [cancelQuestionsAlert show];
}

//Handle register device alert actions
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        //cancel
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextAction:(id)sender {
    
    NSString *errorMessage = [self validateQuestions];
    
    if (errorMessage) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:OM_TXT_ACCEPT, nil] show];
        return;
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(forgotPassFinished)]) {
            
            [userAnswers removeAllObjects];
            
            firstAnswer.questionId = firstQuestion.questionId;
            firstAnswer.text = self.txtFirstQuestion.text;
            
            secondAnswer.questionId = secondQuestion.questionId;
            secondAnswer.text = self.txtSecondQuestion.text;
            
            [userAnswers addObject:firstAnswer];
            [userAnswers addObject:secondAnswer];
            [self createAuthRequestForAnswers];
            
            self.txtFirstQuestion.text = IGEmptyString;
            self.txtSecondQuestion.text = IGEmptyString;
            [self.txtFirstQuestion becomeFirstResponder];
            
            [self.delegate forgotPassFinished];
        }
    }

}

-(void)createAuthRequestForAnswers
{
    IGForgotPasswordRequest *authRequest = [[IGForgotPasswordRequest alloc]init];
    IGPendingActionResponse *pendingResponse = [[IGPendingActionResponse alloc] init];
    IGForgotPasswordResponse *currentAuthResponse = [IGMobileApp sharedInstance].forgotPasswordResponse;
    
    //Authentication request
    authRequest = [IGMobileApp sharedInstance].forgotPasswordRequest;
    
    //Pending action response
    pendingResponse.name = currentAuthResponse.pendingActionRequest.name;
    pendingResponse.failedAttempts = currentAuthResponse.pendingActionRequest.failAttempts;
    pendingResponse.type = currentAuthResponse.pendingActionRequest.pendingActionType;
    
    pendingResponse.answers = userAnswers;
    authRequest.pendingActionResponse = pendingResponse;
}

-(void)forgotPassFinished
{
}

@end
