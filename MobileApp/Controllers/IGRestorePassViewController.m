//
//  IGRestorePassViewController.m
//  MobileApp
//
//  Created by steven muñoz on 11/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGRestorePassViewController.h"
#import "IGLoginViewController.h"
#import  "ActionSheetStringPicker.h"
#import  "ActionSheetDatePicker.h"
#import "IGForgotPasswordRequest.h"
#import "IGMobileApp.h"
#import "UITextField+IGValidateForms.h"
#import "IGRestorePassQuestionsViewController.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "MobileApp-Swift.h"

@interface IGRestorePassViewController ()

@end

@implementation IGRestorePassViewController
{
    int currentFocus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtDocumentNumber.delegate = self;
    self.txtDocumentType.delegate = self;
    
 //_txtDocumentType.text = @"Cédula de Ciudadanía";
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    self.title = OM_TXT_RESTORE_PASSWORD;
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
    
    [IGMobileApp sharedInstance].selectedDocumentType = @"C";
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    UITextField* txt = (UITextField* )[self.view viewWithTag:textField.tag + 1];
    
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        switch (nextTag) {
            case 501:
                //Disable document picker too and show modally
                [txt setEnabled:NO];
                [self showDocumentPicker:textField];
                break;
            case 503:
                [nextResponder becomeFirstResponder];
                break;
            case 504:
                [txt setEnabled:NO];
                if (textField.tag == 503) {
                    textField = txt;
                }
                [self showDatePicker:textField];
                [self.txtDocumentNumber resignFirstResponder];
                break;
            default:
                break;
        }
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(void)forgotPassFinished {
    //delegate method
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)pickDocument:(id)sender {
    
    [self.txtDocumentNumber resignFirstResponder];
    [self showDocumentPicker:sender];
    
}

- (IBAction)pickDate:(id)sender {
    
    [self.txtDocumentNumber resignFirstResponder];
    
    [self showDatePicker:sender];
}

-(void) showDocumentPicker:(id)sender
{
    // Create an array of strings you want to show in the picker:
    NSArray *documentValues = OM_ARRAY_FORGOTPASS_DOCUMENT_TYPES_VALUES;
    NSArray *documentKeys = OM_ARRAY_FORGOTPASS_DOCUMENT_TYPES_KEYS;
    
    ActionSheetStringPicker *stringPicker = [[ActionSheetStringPicker alloc]initWithTitle:OM_PICKER_FORGOTPASS_DOCUMENT_TYPES_TITTLE rows:documentValues initialSelection:0 doneBlock:^   (ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        self.txtDocumentType.text = selectedValue;
        [IGMobileApp sharedInstance].selectedDocumentType = [documentKeys objectAtIndex:selectedIndex];
        
    } cancelBlock:nil origin:sender];
    
    [stringPicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:OM_TXT_ACCEPT  style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    [stringPicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle: OM_TXT_CANCEL style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    [stringPicker showActionSheetPicker];
}

-(void) showDatePicker:(id)sender
{
    
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:OM_PICKER_DATE_FORMAT];
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:OM_PICKER_FORGOTPASS_DATEPICKER_TITTLE datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        NSLog(@"Block Date Picker Canceled");
    } origin:sender];
    
    [datePicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:OM_TXT_ACCEPT  style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    [datePicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:OM_TXT_CANCEL  style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    [datePicker showActionSheetPicker];
}

- (IBAction)sendData:(id)sender {
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@"Restablecer contraseña" value:0] build]];
    NSString *errorMessage = [self validateForm];
    
    if (errorMessage) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:OM_TXT_ACCEPT, nil] show];
        return;
        
    } else {
        if (IPHONE)
        {
        if ([self.delegate respondsToSelector:@selector(forgotPassFinished)]) {
            [self createAuthRequestForForgot];
            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60)
        forBarMetrics:UIBarMetricsDefault];

            
            //[self.delegate forgotPassFinished];
        }
        }
        else
        {
            [self createAuthRequestForForgot];
            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60)
                                                                 forBarMetrics:UIBarMetricsDefault];
        }
    }
    
}


- (NSString *)validateForm {
    
    NSString *errorMessage;
    
    if (![self.txtDocumentType isValidField]){
        errorMessage = OM_MESSAGE_FORGOTPASS_DOCUMENTTYPEREQUIERED;
    } else if (![self.txtDocumentNumber isValidField]){
        errorMessage = OM_MESSAGE_FORGOTPASS_DOCUMENTNUMBERREQUIRED;
    }
    
    return errorMessage;
}

-(void) createAuthRequestForForgot
{
    RequestSwiftObjC *requestSwift = [RequestSwiftObjC new];
    
    

  //  IGForgotPasswordRequest *forgotRequest = [[IGForgotPasswordRequest alloc]init];
   // forgotRequest.email = self.txtEmail.text;
   // forgotRequest.birthDate = self.txtBirthdayDate.text;
  //  forgotRequest.docNumber = self.txtDocumentNumber.text;
   // forgotRequest.docType = [IGMobileApp sharedInstance].selectedDocumentType;

    [requestSwift GETForgetPasswordWithView:self DocType:[IGMobileApp sharedInstance].selectedDocumentType DocNumber:self.txtDocumentNumber.text];
  //  [IGMobileApp sharedInstance].forgotPasswordRequest = forgotRequest;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    /*if([segue.identifier isEqualToString:@"restorePassConfirmationSegue"]){
        IGRestorePassQuestionsViewController *destVc = segue.destinationViewController;
        destVc.delegate = self;
    }*/
    
    if([segue.identifier isEqualToString:@"RestauretPaswordPinController"]){
        RestauretPaswordPinController *destVc = segue.destinationViewController;
        //destVc.delegate = self;
    }
}
@end
