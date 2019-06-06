//
//  OMChangePasswordViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/17/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMChangePasswordViewController.h"
#import "IGMobileApp.h"
#import "IGQuestion.h"
#import "IGAnswer.h"
#import "MZFormSheetController.h"
#import "UITextField+IGValidateForms.h"

@interface OMChangePasswordViewController ()
{
    IGQuestion *question;
    IGAnswer *answer;
    IGAuthenticationResponse *currentAuthResponse;
    NSArray *answers;
}

@end

@implementation OMChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
    self.txtChangePassword.text = currentAuthResponse.pendingActionRequest.message;
    
    question =  [currentAuthResponse.pendingActionRequest.questions objectAtIndex:0];
    answer = [[IGAnswer alloc] init];
    
    answer.questionId = question.questionId;
    self.txtPassword.delegate = self;
    self.txtConfirmPassword.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
  
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if (textField  == self.txtPassword){
        [ self.txtConfirmPassword becomeFirstResponder];
    }else{
        [self dismissKeyboard];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(void)setTexts{
    self.txtChangePassword.text = (currentAuthResponse.pendingActionRequest.message)?currentAuthResponse.pendingActionRequest.message:OM_LABEL_CHANGEPASSWORD_INSTRUCTIONS;
    
    self.lblTitle.text = currentAuthResponse.pendingActionRequest.name;
    [self.btnAccept setTitle:OM_TXT_ACCEPT forState:UIControlStateNormal];
    [self.btnCancel setTitle:OM_TXT_ACCEPT forState:UIControlStateNormal];
    
}

- (IBAction)btnAccept:(id)sender {
    
    NSString *errorMessage = [self validateForm];
    
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:OM_TXT_ACCEPT, nil] show];
        return;
    } else {
        
        if ([self.delegate respondsToSelector:@selector(passwordChanged)]) {
            answer.text = self.txtPassword.text;
            [IGMobileApp sharedInstance].currentNewPassword = self.txtPassword.text;
            [IGMobileApp sharedInstance].currentAnswer = answer;
            [self createAuthRequest];
            [self.delegate passwordChanged];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    
}

- (IBAction)btnCancel:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:OM_NOTIFICATION_CHANGE_PASS_CANCELED object:nil];
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
    }];
}

- (NSString *)validateForm {
    
    NSString *regexSecurity = IG_CHANGE_PASS_SECURITY_VALIDATION;
    //NSString *regexConsecutive = IG_CHANGE_PASS_CONSECUTIVE_CHARS_VALIDATION;
    
    if (![self.txtPassword isValidField]) {
        return OM_MESSASGE_CHANGEPASSWORD_PASSWORDREQUIRED;
    }
    if (! [self.txtConfirmPassword isValidField]){
        return OM_MESSASGE_CHANGEPASSWORD_PASSWORDCONFIRMATIONREQUIRED;
    }
    if ((![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text])){
        return OM_MESSASGE_CHANGEPASSWORD_PASSWORDDOESNOTMATCH;
    }
    if (![self.txtPassword isValidRegex:regexSecurity]){
        return OM_MESSASGE_CHANGEPASSWORD_PASSWORDNOTSECURE;
    }
//    }else if (![self.txtPassword isValidRegex:regexConsecutive]){
//        errorMessage = OM_MESSASGE_CHANGEPASSWORD_PASSWORDCONSECUTIVECHARS;
//    }
//    
    return nil;
}

-(void)createAuthRequest
{
    IGAnswer *selectedAnswer = [IGMobileApp sharedInstance].currentAnswer;
    IGPendingActionResponse *pendingResponse = [[IGPendingActionResponse alloc] init];
    IGAnswer *userAnswer = [[IGAnswer alloc] init];
    
    
    //Pending action response
    pendingResponse.name = currentAuthResponse.pendingActionRequest.name;
    pendingResponse.failedAttempts = currentAuthResponse.pendingActionRequest.failAttempts;
    pendingResponse.type = currentAuthResponse.pendingActionRequest.pendingActionType;
    
    //User answer
    userAnswer.questionId = selectedAnswer.questionId;
    userAnswer.text = selectedAnswer.text;
    userAnswer.answerId = nil;
    answers = [NSArray arrayWithObject:userAnswer];
    
    pendingResponse.answers = answers;
    [IGMobileApp sharedInstance].currentAuthenticationRequest.pendingActionResponse = pendingResponse;
}


@end
