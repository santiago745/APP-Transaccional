//
//  ViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 2/23/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMTermsAndConditionsViewController.h"
#import "OMChangePasswordViewController.h"
#import "OMShowRegisteredQuestionsViewController.h"
#import "IGAuthenticationRequest.h"
#import "IGAskQuestionsViewController.h"
#import "IGRestorePassViewController.h"
#import "IGForgotPasswordRequest.h"
#import "IGRestorePassQuestionsViewController.h"
#import <EAIntroView/EAIntroView.h>

@interface IGLoginViewController : UIViewController <TermsAndConditionsAcceptedDelegate, PasswordChangedDelegate, FinishedRegisteringQuestionsDelegate, FinishedAskingQuestionsDelegate, ForgotPasswordDelegate, UITextFieldDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, EAIntroDelegate>



@property (nonatomic, strong) IGAuthenticationRequest *authRequest;
@property (nonatomic, strong) IGForgotPasswordRequest *forgotPassRequest;

@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnForgot;
@property (weak, nonatomic) IBOutlet UISwitch *uisRememberMe;
@property (weak, nonatomic) IBOutlet UILabel *LblDisclaimer;

    @property (weak, nonatomic) IBOutlet UIButton *btIniciarSesion;
    

//@property (weak, nonatomic) IBOutlet UITableView *tableLogin;

@property (strong, nonatomic) IBOutlet UIView *simulatorView;
@property (strong, nonatomic) IBOutlet UIView *profitabilityView;
@property (strong, nonatomic) IBOutlet UIView *channelGuideView;

@end

