//
//  OMGenerateCertificateViewController.m
//  MobileApp
//
//  Created by Rober on 19/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMGenerateCertificateViewController.h"
#import "MZFormSheetController.h"
#import "IGMobileApp.h"
#import "IGGenerateList.h"
#import "IGFieldGenerateList.h"
#import "IGOption.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"
#import "UITextField+IGValidateForms.h"
#import "IGReportRequest.h"
#import "IGTimeoutApplication.h"
#import "IGFieldReportRequest.h"
#import "MBProgressHUD.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@implementation OMGenerateCertificateViewController
{
    NSArray *certificates;
    NSArray *tagPicker;
    NSArray *tagDatePicker;
    NSMutableArray *dataArrays;
    NSMutableArray *dataArray;
    NSMutableArray *otherArray;
    NSMutableArray *userFields;
    IGGenerateList *certificate;
    IGFieldGenerateList *field;
    IGOption *option;
    UITextField * textFieldOther;
    IGFieldReportRequest *fieldReportRequest;
    int y, tfDate, tfText, contArray;
    BOOL band;
    ActionSheetStringPicker *stringPicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCertificate];

    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closePopups)
                                                 name:kApplicationDidTimeoutNotification
                                               object:nil];
    
    if(IPHONE) {
        self.parentViewController.title = OM_TXT_GENERATE_CERTIFICATE;
    } else {
        self.navigationItem.leftBarButtonItem = backBtn;
        self.navigationItem.hidesBackButton = YES;
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                          NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                          NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                          }];
    }
    
    y = 60;
    tfDate = 0;
    tfText = 0;
    contArray = 0;
    band = true;
    
    dataArrays = [[NSMutableArray alloc] init];
    otherArray = [[NSMutableArray alloc] init];
    userFields = [[NSMutableArray alloc] init];
    tagPicker = OM_ARRAY_TAG_PICKER;
    tagDatePicker = OM_ARRAY_TAG_DATE_PICKER;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    
    if (IPHONE) {
        self.parentViewController.title = OM_TXT_GENERATE_CERTIFICATE;
    } else {
        self.title = OM_TXT_GENERATE_CERTIFICATE;
    }
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendButton:(id)sender {
    
    NSString *errorMessage = [self validateForm];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Certificado Afiliación" action:@"Descarga" label:@"Generar certificado de afiliación" value:0] build]];
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:OM_TXT_ACCEPT, nil] show];
        return;
        
    } else {
        [self createCertificate];
        
        [IGMobileApp sharedInstance].currentDownloadDocumentType = OM_TXT_GENERATE_CERTIFICATE;
        
        self.title = IGEmptyString;
        
        [self performSegueWithIdentifier:@"GenerateCertificateSegue" sender:nil];
    }
}

- (NSString *)validateForm {
    
    NSString *errorMessage;
    
    for (UITextField *textField in self.view.subviews)
    {
        if ([textField isKindOfClass:[UITextField class]])
        {
            if (![textField isValidField]){
                errorMessage = OM_MESSASGE_FIELDREQUIRED;
            }
        }
    }
    
    return errorMessage;
}

-(void) getCertificate {
    
    IGContract *contract = [IGMobileApp sharedInstance].currentSelectedContract;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[IGMobileApp sharedInstance] getGenerateList:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber withDocType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withProduct:contract.productCode withPlan:contract.planCode withContract:contract.number withBlock:^(NSError *error) {
        
        [hud hide:YES];
        
        if(!error) {
            certificates = [[NSArray alloc]init];
            certificates = [IGMobileApp sharedInstance].currentCertificates;
            if (certificates.count > 0) {
                certificate = [[IGMobileApp sharedInstance].currentCertificates objectAtIndex:0];
                [self generateCertificate];
            } else {
                [self showAlertError:OM_ALERT_GENERATE_CERTIFICATE];
            }
            
        } else {
            [self showAlertError:OM_MESSAGE_LOGIN_ERRORONSERVICE];
        }
    }];
}

-(void) generateCertificate {
    
    NSInteger num = certificate.fields.count;
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = certificate.caption;
    self.sendButton.hidden = NO;
    
    for (int i = 0; i < num; i++) {
        
        if (USE_TEST_REPOS) {
            field = [MTLJSONAdapter modelOfClass:IGFieldGenerateList.class fromJSONDictionary:[certificate.fields objectAtIndex:i] error:nil];
        } else {
            field = ((IGFieldGenerateList *)[certificate.fields objectAtIndex:i]);
        }
        
        
        UILabel *label = [[UILabel alloc]init];
        if (IPHONE) {
            label.frame = CGRectMake(10,y,(self.view.bounds.size.width - 20),40);
        } else {
            label.frame = CGRectMake(20,y,120,40);
        }
        label.text= field.caption;
        label.textColor=[UIColor blackColor];
        label.numberOfLines = 0;
        if (IPHONE) {
            label.font = OM_FONT_HELVETICANEUE_BIG;
        } else {
            label.font = OM_FONT_HELVETICANEUE_BIGGEST;
        }
        [self.view addSubview:label];
        
        if (field.fieldType == 1) {
            UISwitch *mySwitch = [[UISwitch alloc] init];
            if (IPHONE) {
                mySwitch.frame = CGRectMake(110, y+5, 0, 0);
            } else {
                mySwitch.frame = CGRectMake(150, y+5, 0, 0);
            }
            mySwitch.restorationIdentifier = field.key;
            [self.view addSubview:mySwitch];
            
        } else if (field.fieldType == 2 || field.fieldType == 4) {
            
            [self createTextField:field.fieldType key:field.key];
            
        } else if (field.fieldType == 3 || field.fieldType == 5) {
            
            [self createTextField:field.fieldType key:field.key];
            
            if (field.fieldType == 3) {
                tfDate ++;
            } else {
                tfText ++;
                contArray ++;
            }
        }
        
        if (band) {
            if (IPHONE) {
                y = y + 40;
            } else {
                y = y + 50;
            }
        } else {
            band = true;
        }
    }
}

- (void) closePopups{
    
    [stringPicker dismissPicker];
    [self exitPopover];
}

- (IBAction)closeButton:(id)sender {
    [self exitPopover];
    
}


-(void) exitPopover {
    [userFields removeAllObjects];
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
    }];
}


-(void) createCertificate
{
    IGContract *contract = [IGMobileApp sharedInstance].currentSelectedContract;
    [userFields removeAllObjects];
    IGReportRequest *reportRequest = [[IGReportRequest alloc]init];
    reportRequest.reportType = certificate.reportTypeId;
    reportRequest.reportCode = certificate.reportCode;
    reportRequest.docType = [IGMobileApp sharedInstance].currentAuthenticationResponse.docType;
    reportRequest.docNumber = [IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber;
    reportRequest.contract = contract.number;
    reportRequest.product = contract.productCode;
    reportRequest.plan = contract.planCode;
    
    for (UITextField *textField in self.view.subviews)
    {
        if ([textField isKindOfClass:[UITextField class]])
        {
            if (![textField.text isEqualToString:@"Otros"]) {
                fieldReportRequest = [[IGFieldReportRequest alloc]init];
                fieldReportRequest.key = textField.restorationIdentifier;
                fieldReportRequest.value = textField.text;
                
                [userFields addObject:fieldReportRequest];
            }
        }
    }
    
    for (UISwitch *mySwitch in self.view.subviews)
    {
        if ([mySwitch isKindOfClass:[UISwitch class]])
        {
            fieldReportRequest = [[IGFieldReportRequest alloc]init];
            fieldReportRequest.key = mySwitch.restorationIdentifier;
            
            if([mySwitch isOn]){
                fieldReportRequest.value = @"True";
            } else{
                fieldReportRequest.value = @"False";
            }
            
            [userFields addObject:fieldReportRequest];
        }
    }
    
    reportRequest.fields = userFields;
    
    [IGMobileApp sharedInstance].currentReportRequest = reportRequest;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *) textField {
    
    if (textField.tag == 400){
        return YES;
    }
    if (textField.tag > 200 && textField.tag < 206) {
        
        contArray = (int)textField.tag - 201;
        
         stringPicker = [[ActionSheetStringPicker alloc]initWithTitle:IGEmptyString rows:[dataArrays objectAtIndex:contArray] initialSelection:0 doneBlock:^   (ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
            textField.text = selectedValue;
            
            for (int i=0; i<[otherArray count]; i++)
            {
                if([[otherArray objectAtIndex:i] isKindOfClass:[UITextField class]])
                {
                    UITextField *textFieldNew=(UITextField *)[otherArray objectAtIndex:i];
                    if (textFieldNew.tag == 400) {
                        [[otherArray objectAtIndex:i] removeFromSuperview];
                        [otherArray removeObjectAtIndex:i];
                    }
                }
            }
            
            if ([textField.text isEqualToString:@"Otros"]) {
                CGFloat height = textField.frame.origin.y + 50.0f;
                [self createTextFieldOthers:height tag:textField.tag key:textField.restorationIdentifier];
            }
            
        } cancelBlock:nil origin:textField];
        
        [stringPicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:OM_TXT_ACCEPT  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [stringPicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle: OM_TXT_CANCEL style:UIBarButtonItemStylePlain target:nil action:nil]];
        [stringPicker showActionSheetPicker];
        
    } else if (textField.tag != 400){
        
        NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:OM_PICKER_DATE_FORMAT];
        
        ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:IGEmptyString datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            
            textField.text = [dateFormater stringFromDate:selectedDate];
            
        } cancelBlock:nil origin:textField];
        
        [datePicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:OM_TXT_ACCEPT  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [datePicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:OM_TXT_CANCEL  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [datePicker showActionSheetPicker];
        
    }
    
    return NO;
}

- (void)createTextField: (NSInteger) type key:(NSString *) key {
    
    UITextField * textField = [[UITextField alloc] init];
    
    if (IPHONE) {
        y = y + 30;
        textField.frame = CGRectMake(10, y+5, (self.view.bounds.size.width - 20), 30);
    } else {
        textField.frame = CGRectMake(150, y+5, 350, 30);
    }
    
    textField.textColor = [UIColor blackColor];
    textField.font = OM_FONT_HELVETICANEUE_BIGGEST;
    textField.backgroundColor=[UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.restorationIdentifier = key;
    
    switch (type) {
        case 2:
            textField.returnKeyType = UIReturnKeyDone;
            textField.keyboardType = UIKeyboardTypeDefault;
            break;
        case 3:
            textField.tag = [[tagDatePicker objectAtIndex:tfDate] integerValue];
            textField.delegate = self;
            break;
        case 4:
            textField.returnKeyType = UIReturnKeyDone;
            textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case 5:
            textField.tag = [[tagPicker objectAtIndex:tfText] integerValue];
            textField.delegate = self;
            
            dataArray = [[NSMutableArray alloc] init];
            
            for (int j = 0; j < field.options.count; j++) {
                option = [field.options objectAtIndex:j];
                [dataArray addObject:option.caption];
                if ([option.caption isEqualToString:@"Otros"]) {
                    if (IPHONE) {
                        y = y + 80;
                    } else {
                        y = y + 100;
                    }
                    
                    band = false;
                }
                
            }
            
            [dataArrays addObject:[dataArray copy]];
            
            break;
    }
    
    [self.view addSubview:textField];
    
}

- (void)createTextFieldOthers: (NSInteger) height tag:(NSInteger) tag key:(NSString *) key {
    
    textFieldOther = [[UITextField alloc] init];
    
    if (IPHONE) {
        textFieldOther.frame = CGRectMake(10, height-10, (self.view.bounds.size.width - 20), 30);
    } else {
        textFieldOther.frame = CGRectMake(150, height, 350, 30);
    }
    
    textFieldOther.textColor = [UIColor blackColor];
    textFieldOther.font = OM_FONT_HELVETICANEUE_BIGGEST;
    textFieldOther.placeholder = OM_TXT_OTHERS;
    textFieldOther.backgroundColor=[UIColor whiteColor];
    textFieldOther.borderStyle = UITextBorderStyleRoundedRect;
    textFieldOther.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFieldOther.autocorrectionType = UITextAutocorrectionTypeNo;
    textFieldOther.returnKeyType = UIReturnKeyDone;
    textFieldOther.keyboardType = UIKeyboardTypeDefault;
    textFieldOther.tag = 400;
    textFieldOther.delegate = self;
    textFieldOther.restorationIdentifier = key;
    
    [otherArray addObject:textFieldOther];
    
    [self.view addSubview:textFieldOther];
}

-(void) hideHud:(UIWindow *)actualWindow {
    [MBProgressHUD hideHUDForView:actualWindow animated:YES];
}

-(void) showAlertError:(NSString *)errorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:errorMessage delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
    [alert show];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{

    if (textField.tag == 400){
        [self.view endEditing:YES];
        return YES;
    }
    
    return NO;
}

@end
