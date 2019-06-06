//
//  IGAskQuestionsViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/20/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGAskQuestionsViewController.h"
#import "IGMobileApp.h"
#import "IGQuestion.h"
#import "IGAnswer.h"
#import "UITextField+IGValidateForms.h"

@interface IGAskQuestionsViewController ()

@end

@implementation IGAskQuestionsViewController
{
    NSMutableArray *userAnswers;
    IGQuestion *firstQuestion, *secondQuestion;
    IGAnswer *firstAnswer, *secondAnswer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userAnswers = [[NSMutableArray alloc]init];
    firstAnswer = [[IGAnswer alloc]init];
    secondAnswer = [[IGAnswer alloc]init];
    
    IGAuthenticationResponse *currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
    
    if (currentAuthResponse.pendingActionRequest.failAttempts != 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT
                                                        message:currentAuthResponse.pendingActionRequest.message
                                                       delegate:nil
                                              cancelButtonTitle:OM_TXT_ACCEPT
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    [self.myScrollView setContentOffset:CGPointMake(0, -self.myScrollView.contentInset.top) animated:YES];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
   self.title = OM_TXT_SECURITY_QUESTIONS;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
     NSMutableArray  *askQuestions = [[NSMutableArray alloc]initWithArray:[IGMobileApp sharedInstance].currentAuthenticationResponse.pendingActionRequest.questions];
    
    [self setTexts:askQuestions];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTexts:(NSMutableArray *)questions {
   
    firstQuestion = [questions objectAtIndex:0];
    secondQuestion = [questions objectAtIndex:1];
    
    self.lblIntructions.text = OM_LABEL_ASKQUESTIONS_INSTRUCTIONS;
    self.lblTitle.text = OM_DEAR_CLIENT;
    [self.btnEnd setTitle:OM_TXT_CLOSE forState:UIControlStateNormal] ;
    self.lblFirstQuestion.text = firstQuestion.text;
    self.lblSecondQuestion.text = secondQuestion.text;
    
}

- (NSString *)validateQuestions {
    
    NSString *errorMessage;
    
    if (![self.txtFirstQuestion isValidField]){
        errorMessage = OM_MESSAGE_REGISTERQUESTION_ANSWERREQUIRED;
        [self.txtFirstQuestion becomeFirstResponder];
    } else if (![self.txtSecondQuestion isValidField]){
        errorMessage = OM_MESSAGE_REGISTERQUESTION_ANSWERREQUIRED;
         [self.txtSecondQuestion becomeFirstResponder];
    }
    return errorMessage;
}

-(IBAction)backButtonPressed:(id)sender{
    [self displayCancelAlert];
}

-(void) displayCancelAlert
{
    UIAlertView *cancelQuestionsAlert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_ALERT_REGISTERQUESTION_CANCELQUESTIONS_MESSAGE delegate:self cancelButtonTitle:OM_TXT_CANCEL otherButtonTitles:OM_TXT_ACCEPT, nil];
    
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

- (IBAction)finish:(id)sender {
    
    NSString *errorMessage = [self validateQuestions];
    
    if (errorMessage) {
        
        [[[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:OM_TXT_ACCEPT, nil] show];
        return;
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(FinishedAskingQuestions)]) {
            
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
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.delegate FinishedAskingQuestions];
            
            
        }
    }
}

-(void)createAuthRequestForAnswers
{
    IGAuthenticationRequest *authRequest = [[IGAuthenticationRequest alloc]init];
    IGPendingActionResponse *pendingResponse = [[IGPendingActionResponse alloc] init];
    IGAuthenticationResponse *currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
    
    //Authentication request
    authRequest = [IGMobileApp sharedInstance].currentAuthenticationRequest;
    
    //Pending action response
    pendingResponse.name = currentAuthResponse.pendingActionRequest.name;
    pendingResponse.failedAttempts = currentAuthResponse.pendingActionRequest.failAttempts;
    pendingResponse.type = currentAuthResponse.pendingActionRequest.pendingActionType;
    
    pendingResponse.answers = userAnswers;
    authRequest.pendingActionResponse = pendingResponse;
}

@end
