//
//  OMRegisterQuestionsViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/18/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMRegisterQuestionsViewController.h"
#import "IGAuthenticationResponse.h"
#import "IGMobileApp.h"
#import "IGQuestion.h"
#import "OMShowRegisteredQuestionsViewController.h"
#import "UITextField+IGValidateForms.h"

@interface OMRegisterQuestionsViewController (){
    NSMutableArray *randomQuestions, *totalQuestions, *pendingResponseQuestions, *userArraySelectedQuestions;
    IGQuestion *singleQuestion, *selectedQuestion;
    IGAnswer *selectedAnswer;
    IGAuthenticationResponse *currentAuthResponse;
    UIFont *cellFont;
    UIView *bgSelectedCellColorView;
    int currentStep;
}

@end

@implementation OMRegisterQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblQuestions.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    [self.myScrollView setContentOffset:CGPointMake(0, -self.myScrollView.contentInset.top) animated:YES];

    currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
    singleQuestion = [[IGQuestion alloc]init];
    userArraySelectedQuestions = [[NSMutableArray alloc]init];
    bgSelectedCellColorView = [[UIView alloc] init];
    pendingResponseQuestions = [[NSMutableArray alloc] init];
    
    cellFont = OM_FONT_ARIAL_BIG;
    
    totalQuestions = [[NSMutableArray alloc]initWithArray:currentAuthResponse.pendingActionRequest.questions];
    randomQuestions = [self loadRandomQuestions:totalQuestions];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    self.title = OM_TXT_ASK_QUESTION;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
}

-(void)viewWillAppear:(BOOL)animated{
    currentStep = 1;
    [userArraySelectedQuestions removeAllObjects];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_ALERT_REGISTERQUESTION_ALERTERRORMESSAGE delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
    [alert show];
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [randomQuestions count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"questionsCell"  forIndexPath:indexPath];
    
    singleQuestion = [randomQuestions objectAtIndex:indexPath.item];
    cell.textLabel.text = singleQuestion.text;
    cell.textLabel.font = cellFont;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor colorWithRed:48.0f/255.0f green:48.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_num_%d", indexPath.row + 1]];
    bgSelectedCellColorView.backgroundColor = OM_COLOR_LIGHT_GREEN;
    [cell setSelectedBackgroundView:bgSelectedCellColorView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_num_%d_white", indexPath.row + 1]];
    //mark selected question
    self.txtAnswer.text = IGEmptyString;
    self.txtConfirmAnswer.text = IGEmptyString;
    selectedAnswer = [[IGAnswer alloc]init];
    selectedQuestion = [randomQuestions objectAtIndex: indexPath.row];
    selectedAnswer.questionId = selectedQuestion.questionId;
    [self.txtAnswer becomeFirstResponder];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithRed:48.0f/255.0f green:48.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_num_%d", indexPath.row + 1]];
    
    //add again unselected question
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

-(NSMutableArray *) loadRandomQuestions: (NSMutableArray *) questions
{
    NSMutableArray * randomizedQuestions;
     randomizedQuestions = [self getRandomQuestions:questions];
    
    return randomizedQuestions;
}

-(NSMutableArray *) getRandomQuestions:(NSMutableArray *)questionsArray
{
    int remainingItems = 4;
    NSMutableArray *selectedQuestions = [[NSMutableArray alloc]init];
    
    if ([questionsArray count] >= remainingItems)
    {
        while (remainingItems > 0) {
            
            singleQuestion = [questionsArray objectAtIndex: arc4random() % [questionsArray count]];
         
            if (![selectedQuestions containsObject: singleQuestion])
            {
                [selectedQuestions addObject: singleQuestion];
                remainingItems --;
            }
        }
    }
    
    return selectedQuestions;
}

-(void) reloadData
{
    self.txtAnswer.text = IGEmptyString;
    self.txtConfirmAnswer.text = IGEmptyString;
    [self.txtAnswer endEditing:YES];
    [self.txtConfirmAnswer endEditing:YES];
    self.imageSteps.image = [UIImage imageNamed:[NSString stringWithFormat:@"question-step-%d", currentStep]];
    selectedQuestion = [[IGQuestion alloc]init];
    randomQuestions = [self loadRandomQuestions:totalQuestions];
    [self.tblQuestions reloadData];
}

- (IBAction)btnAcceptAnswer:(id)sender {
    
    NSString *errorMessage = [self validateQuestions];
    if (errorMessage) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:OM_TXT_ACCEPT, nil] show];
        return;
        
    } else {
        
        selectedAnswer.text = self.txtAnswer.text;
        [pendingResponseQuestions addObject:selectedAnswer];
        [userArraySelectedQuestions addObject:selectedQuestion];
        
        if (currentStep == 5) {
            
            [self createAuthRequestWithArray:pendingResponseQuestions];
            [self performSegueWithIdentifier:@"showRegisteredQuestionsSegue" sender:nil];
            
        } else {
            
            [totalQuestions removeObject:selectedQuestion];
            currentStep++;
            [self reloadData];
        }
        
    }
}

- (NSString *)validateQuestions {
    
    NSString *errorMessage;
    NSString *validationRegex = IG_REGISTER_QUESTION_VALIDATION;
    
    if (selectedQuestion.text == nil) {
        errorMessage = OM_MESSAGE_REGISTERQUESTION_QUESTIONREQUIRED;
    } else if (![self.txtAnswer isValidField]){
        errorMessage = OM_MESSAGE_REGISTERQUESTION_ANSWERREQUIRED;
    } else if (![self.txtAnswer isValidRegex:validationRegex]) {
        self.txtAnswer.text = IGEmptyString;
        errorMessage = OM_MESSAGE_REGISTERQUESTION_VALIDATEREGEX;
    } else if (![self.txtConfirmAnswer isValidField]) {
        errorMessage = OM_MESSAGE_REGISTERQUESTION_CONFIRMANSWER;
    } else if (![self.txtAnswer.text isEqualToString:self.txtConfirmAnswer.text]){
        self.txtAnswer.text = IGEmptyString;
        self.txtConfirmAnswer.text = IGEmptyString;
        [self.txtAnswer changeViewToInvalid];
        [self.txtConfirmAnswer changeViewToInvalid];
        errorMessage = OM_MESSAGE_REGISTERQUESTION_MATCHANSWER;
    }
    
    return errorMessage;
}

-(void)createAuthRequestWithArray:(NSMutableArray *)answersArray
{
    IGAuthenticationRequest *authRequest = [[IGAuthenticationRequest alloc]init];
    IGPendingActionResponse *pendingResponse = [[IGPendingActionResponse alloc] init];

    //Authentication request
    authRequest = [IGMobileApp sharedInstance].currentAuthenticationRequest;
    
    //Pending action response
    pendingResponse.name = currentAuthResponse.pendingActionRequest.name;
    pendingResponse.failedAttempts = currentAuthResponse.pendingActionRequest.failAttempts;
    pendingResponse.type = currentAuthResponse.pendingActionRequest.pendingActionType;
    
    pendingResponse.answers = answersArray;
    authRequest.pendingActionResponse = pendingResponse;
    [IGMobileApp sharedInstance].selectedQuestions = userArraySelectedQuestions;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    OMShowRegisteredQuestionsViewController *destVc = segue.destinationViewController;
    destVc.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//hide keyboard on screen tap
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}

-(void)hideKeyboard {
    [self.view endEditing:YES];
}

-(void)finishedRegisteringQuestions{
    if ([self.delegate respondsToSelector:@selector(finishedRegisteringQuestions)]) {
        [self.delegate finishedRegisteringQuestions];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)answerTextChanged:(id)sender {
    [self validateTextChanged:self.txtAnswer];
}

- (IBAction)confirmTextChanged:(id)sender {
    [self validateTextChanged:self.txtConfirmAnswer];
}

-(void) validateTextChanged:(UITextField *)textField
{
    if (textField.text.length > 0 && textField.text.length < 4){
        [textField changeViewToInvalid];
    } else {
        [textField changeViewToValid];
    }
}

@end
