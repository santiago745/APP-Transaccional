//
//  OMTermsAndConditionsViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/17/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMTermsAndConditionsViewController.h"
#import "IGAuthenticationResponse.h"
#import "IGMobileApp.h"
#import "IGQuestion.h"
#import "IGAnswer.h"


@interface OMTermsAndConditionsViewController ()
{
    
    IGQuestion *question;
    IGAnswer *answerAccept;
    NSArray *answers;
    NSUInteger termsCount;
}

@end

@implementation OMTermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    termsCount = 0;
    
    IGAuthenticationResponse *currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
    
    question =  [currentAuthResponse.pendingActionRequest.questions objectAtIndex:0];
    answerAccept = [question.DefaultAnswers firstObject];
    
    answerAccept.questionId = question.questionId;
    
    self.txtTitle.text = OM_TXT_TERMS_CONDITIONS;
    self.txtTitle.font = OM_FONT_ARIAL_BIGGEST;
    self.txtTitle.textColor = OM_COLOR_GRAY;
    self.txtTitle.textAlignment = NSTextAlignmentCenter;
    
    self.txtText.font = OM_FONT_ARIAL_BIG;
    self.txtText.textColor = [UIColor blackColor];
    self.txtText.attributedText = [[NSAttributedString alloc] initWithData:[question.text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    NSRange range = NSMakeRange(0, 1);
    [self.txtText scrollRangeToVisible:range];
    
    self.btnAccept.title = answerAccept.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AcceptTerms:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(termsAccepted)]) {
        [IGMobileApp sharedInstance].currentAnswer = answerAccept;
        [self createAuthRequest];
        [self.delegate termsAccepted];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)RejectTerms:(id)sender {
    
    [self showRejectTermsAlertView];
}

-(void)showRejectTermsAlertView{
    
    if (termsCount == 0){
        UIAlertView *rejectTermsAlert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_ALERT_TERMSANDCONDITIONS_ALERTMESSAGE delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
        [rejectTermsAlert show];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//Handle register device alert actions
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    termsCount++;
}

-(void)createAuthRequest
{
    IGAuthenticationResponse *currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
    IGAnswer *selectedAnswer = [IGMobileApp sharedInstance].currentAnswer;
    IGPendingActionResponse *pendingResponse = [[IGPendingActionResponse alloc] init];
    IGAnswer *userAnswer = [[IGAnswer alloc] init];
    
   //Pending action response
    pendingResponse.name = currentAuthResponse.pendingActionRequest.name;
    pendingResponse.failedAttempts = currentAuthResponse.pendingActionRequest.failAttempts;
    pendingResponse.type = currentAuthResponse.pendingActionRequest.pendingActionType;
    
    //User answer
    userAnswer.questionId = selectedAnswer.questionId;
    userAnswer.answerId = selectedAnswer.answerId;
    userAnswer.text = nil;
    answers = [NSArray arrayWithObject:userAnswer];
    
    pendingResponse.answers = answers;
    [IGMobileApp sharedInstance].currentAuthenticationRequest.pendingActionResponse = pendingResponse;
}

@end
