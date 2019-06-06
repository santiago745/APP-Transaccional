//
//  ViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 2/23/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGLoginViewController.h"
#import "IGMobileApp.h"
#import "Constants.h"
#import "IGQuestion.h"
#import "IGAnswer.h"
#import "OMTermsAndConditionsViewController.h"
#import "MBProgressHUD.h"
#import "OMChangePasswordViewController.h"
#import "OMRegisterQuestionsViewController.h"
#import "MZFormSheetController.h"
#import "IGLocalStorageService.h"
#import "IGTimeoutApplication.h"
#import "IGRestorePassFirstScreenViewController.h"
#import "UITextField+IGValidateForms.h"
#import "IGRestorePassQuestionsViewController.h"
#import "OMWebViewController.h"
#import "IGAPIClient.h"
#import "IGLoginTableViewCell.h"
#import <SMPageControl/SMPageControl.h>
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "MobileApp-Swift.h"

@interface IGLoginViewController ()

@property (nonatomic, strong) IGPendingActionRequest *currentPendingActionRequest;

@end

@implementation IGLoginViewController
{
    NSArray *publicMenu;
    NSArray *publicMenuIcons;
    NSArray *answers;
    IGAnswer *acceptRegisterDeviceAnswer, *declineRegisterDeviceAnswer;
    IGQuestion *question;
    NSString *url;
    NSString *titleText;
    NSInteger lastPendingAction;
    NSArray *imageItem;
    NSArray *titleItem;
    NSArray *descriptionItem;
    NSArray *webItem;
    
    
    //SpinnerController *uview;
    //ShowControllsController *showcon;
}


//Method


-(BOOL) needsUpdate{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@", appID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if ([lookup[@"resultCount"] integerValue] == 1){
        NSString* appStoreVersion = lookup[@"results"][0][@"version"];
        NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
        if (![appStoreVersion isEqualToString:currentVersion]){
            NSLog(@"Need to update [%@ != %@]", appStoreVersion, currentVersion);
            return YES;
        }
    }
    return NO;
}

-(IGAuthenticationRequest*)authRequest{
    if (!_authRequest) {
        _authRequest = [IGMobileApp sharedInstance].currentAuthenticationRequest;
    }
    
    return _authRequest;
}

-(IGForgotPasswordRequest*)forgotPassRequest{
    if (!_forgotPassRequest) {
        _forgotPassRequest = [IGMobileApp sharedInstance].forgotPasswordRequest;
    }
    
    return _forgotPassRequest;
}


-(void)viewWillAppear:(BOOL)animated{
    RequestSwiftObjC *Object = [RequestSwiftObjC alloc];
    [Object GetCleanLogin];
    [super viewWillAppear:animated];
    
    
    lastPendingAction = 0;
    if ([[IGLocalStorageService sharedInstance] getFileFrom:@"txtLogin"]) {
        self.txtLogin.text = [[IGLocalStorageService sharedInstance] getFileFrom:@"txtLogin"];
        [self.uisRememberMe setOn:YES];
    }
    if (![[IGLocalStorageService sharedInstance] getFileFrom:@"firstTime"]) {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
        [self showIntroWithCrossDissolve];
        
    }
    //Logo
    
    [(IGTimeoutApplication *)[UIApplication sharedApplication] invalidateTimer];
    
    self.navigationController.navigationBar.topItem.title = IGEmptyString;
    self.title = @"";
    [self.navigationController.navigationBar setTintColor:OM_COLOR_LIGHT_GREEN];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [image setContentMode:UIViewContentModeCenter];
    [self.navigationController.navigationBar.topItem setTitleView:image];
    
    [self.btnForgot setImage:[UIImage imageNamed:@"icon_key"] forState:UIControlStateNormal];
    
    //Green bottom border
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    [navBorder setBackgroundColor:IG_NAV_BAR_BORDER_COLOR];
    [self.navigationController.navigationBar addSubview:navBorder];
    
    
    
}

-(BOOL) connectedToInternet

{
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://www.google.com"]];
    
    return ( URLString != NULL ) ? YES : NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changePasswordCanceled)
                                                 name:OM_NOTIFICATION_CHANGE_PASS_CANCELED
                                               object:nil];
    
    if (IPHONE) {
        imageItem = OM_ARRAY_IMAGE_ITEM_LOGIN;
        titleItem = OM_ARRAY_TITLE_ITEM_LOGIN;
        descriptionItem = OM_ARRAY_DESCRIPTION_ITEM_LOGIN;
        webItem = OM_ARRAY_WEB_ITEM_LOGIN;
    } else {
        // Do any additional setup after loading the view, typically from a nib.
        UITapGestureRecognizer *profitability = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showProfitabilityView:)];
        [self.profitabilityView addGestureRecognizer:profitability];
        
        UITapGestureRecognizer *simulator = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSimulatorView:)];
        [self.simulatorView addGestureRecognizer:simulator];
        
        UITapGestureRecognizer *channelGuide = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelGuideView:)];
        [self.channelGuideView addGestureRecognizer:channelGuide];
        
    }
    
    RequestSwiftObjC *requestSwift = [RequestSwiftObjC new];
    
    [requestSwift getDataLocationsWithView:self];
    //    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    //    [tracker set:kGAIScreenName value:@"Inicio Login"];
    //    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    _btIniciarSesion.layer.cornerRadius = 8.0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"ShowPaswords"
                                               object:nil];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
  
    
  [GetRetirementVersionControl getRetirementVersionControlWithController:self OS:@"" Ok:^(RetirementVersionControlObject * rest) {
      NSString *versionApp = [rest versionApp];
      
  
      //Borrar David
      /*if([versionApp isEqualToString:(version)]){
          
      }else{
          self.logoutButtonPressed;
      }*/
  }];
    
    [RequestDisclaimerClass requestDisclaimerClassWithController:self Ok:^(NSString * res) {
        self.LblDisclaimer.text = res;
    }];
    //self.txtLogin.returnKeyType = UIReturnKeyNext;
    //self.txtPassword.returnKeyType = UIReturnKeyNext;
    
    self.txtLogin.delegate = self;
    self.txtPassword.delegate = self;
    
   // getContenedor(controller: self, numeroDeDocumento: "", tipoDeDocument: "", Ok: {rest in})
    
}

- (void)logoutButtonPressed
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Apreciado Cliente"
                                 message:@"Por favor actualice la aplicación con la última versión disponible para continuar"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Actualizar"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                   // [self clearAllData];
                                    NSString *iTunesLink = @"https://itunes.apple.com/co/app/old-mutual-colombia-app/id1022989235?mt=8";
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
                                    
                                    exit(0);
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                                   exit(0);
                               }];
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    OMChangePasswordViewController *changePasswordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordController"];
    
    changePasswordViewController.delegate = self;
    
    // present form sheet with view controller
    [self mz_presentFormSheetWithViewController:changePasswordViewController animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        formSheetController.shouldDismissOnBackgroundViewTap = NO;
        
    }];
}


-(void)clearControls{
    self.txtLogin.text = IGEmptyString;
    self.txtPassword.text= IGEmptyString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    //Green bottom border
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    [navBorder setBackgroundColor:IG_NAV_BAR_BORDER_COLOR];
    [self.navigationController.navigationBar addSubview:navBorder];
    
}

-(void)hideKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)authenticate:(id)sender {
    /*
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    indicator.layer.cornerRadius = 5;
    indicator.layer.masksToBounds = YES;
    indicator.backgroundColor =  UIColor.lightGrayColor;
    indicator.alpha = 0.5;
    indicator.color = UIColor.blackColor;
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;

    
    [indicator startAnimating];
    */
   // UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
   // [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@"Ingresar al portal" value:0] build]];
    
    NSString *errorMessage = [self validateLogin];
    
    if (errorMessage) {
        
        [[[UIAlertView alloc]
          initWithTitle:OM_DEAR_CLIENT
          message:errorMessage
          delegate:nil
          cancelButtonTitle:nil
          otherButtonTitles:OM_TXT_ACCEPT
         
          ,  nil] show];
        
        return;
        
    } else {
        
        [self hideKeyboard];
        self.authRequest = [[IGAuthenticationRequest alloc]init];
        self.authRequest.login = self.txtLogin.text;
        self.authRequest.password = self.txtPassword.text;
        self.authRequest.deviceNumber = [IGMobileApp sharedInstance].appUniqueIdentifier;
        
        if ([self.uisRememberMe isOn]) {
            [[IGLocalStorageService sharedInstance] save:self.txtLogin.text To:@"txtLogin"];
            self.txtPassword.text= IGEmptyString;
        }else{
            [[IGLocalStorageService sharedInstance] deleteFile:@"txtLogin" error:nil];
            self.txtLogin.text = IGEmptyString;
            self.txtPassword.text= IGEmptyString;
        }
       // [indicator stopAnimating];
        [self attemptLogin];
    }
}

- (void)showIntroWithCrossDissolve {
    
    
    NSString *pageImage1;
    NSString *pageImage2;
    NSString *pageImage3;
    NSString *pageImage4;
    NSString *pageImage5;
    NSString *pageImage6;
    
    
    if (IPAD){
        pageImage1 = @"visita_01_tab";
        pageImage2 = @"visita_02_tab";
        pageImage3 = @"visita_03_tab";
        pageImage4 = @"visita_04_tab";
        pageImage5 = @"visita_05_tab";
        pageImage6 = @"visita_06_tab";
        
    }else{
        pageImage1 = @"visita_01";
        pageImage2 = @"visita_02";
        pageImage3 = @"visita_03";
        pageImage4 = @"visita_04";
        pageImage5 = @"visita_05";
        pageImage6 = @"visita_06";
    }
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pageImage1]];
    page1.titleIconView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    page1.titleIconPositionY = 0;
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pageImage2]];
    page2.titleIconView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    page2.titleIconPositionY = 0;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pageImage3]];
    page3.titleIconView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    page3.titleIconPositionY = 0;
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pageImage4]];
    page4.titleIconView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    page4.titleIconPositionY = 0;
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pageImage5]];
    page5.titleIconView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    page5.titleIconPositionY = 0;
    
    EAIntroPage *page6 = [EAIntroPage page];
    page6.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pageImage6]];
    page6.titleIconView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    page6.titleIconPositionY = 0;
    
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5,page6]];
    [intro setDelegate:self];
    [intro.skipButton setTitle:@"Omitir" forState:UIControlStateNormal];
    intro.pageControl.currentPageIndicatorTintColor = IG_NAV_BAR_COLOR;
    
    SMPageControl *pageControl = [[SMPageControl alloc] init];
    pageControl.pageIndicatorImage = [UIImage imageNamed:@"pageDot"];
    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"selectedPageDot"];
    [pageControl sizeToFit];
    intro.pageControl = (UIPageControl *)pageControl;
    
    if (IS_IPHONE_4_OR_LESS) {
        
        intro.pageControlY = 32.f;
    }
    else if (IS_IPHONE_5) {
        
        intro.pageControlY = 35.0f;
    }
    else {
        
        intro.pageControlY = 40.0f;
    }
    
    
    
    [intro showInView:self.view animateDuration:0.5];
}

- (void)introDidFinish:(EAIntroView *)introView {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    UIAlertView *firstTimeAlert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_FIRST_TIME_MESSAGE delegate:self cancelButtonTitle:declineRegisterDeviceAnswer.text otherButtonTitles:OM_TXT_ACCEPT, nil];
    
    firstTimeAlert.tag = 11;
    [firstTimeAlert show];
}

- (NSString *)validateLogin {
    
    NSString *errorMessage;
    
    if (![self.txtLogin isValidField]) {
        errorMessage = OM_MESSAGE_LOGIN_USERREQUIRE;
        [self.txtLogin becomeFirstResponder];
    } else if (![self.txtPassword isValidField]){
        errorMessage = OM_MESSAGE_LOGIN_PASSREQUIRE;
        [self.txtPassword becomeFirstResponder];
    }
    return errorMessage;
}

//Delegate method terms and conditions
-(void)termsAccepted
{
    [self prepareAuthForLogin];
}

//Delegate method change password
-(void)passwordChanged
{
    [self hideChangePassPopUpwithBlock:^(NSError *error) {
        [self prepareAuthForLogin];
    }];
    
}

//Delegate method change password
-(void)changePasswordCanceled
{
    lastPendingAction = 0;
    
}

//Delegate method register security questions
-(void)finishedRegisteringQuestions
{
    [self prepareAuthForLogin];
}

-(void)FinishedRestoreAnsweringQuestions
{
    [self prepareAuthForRestorePass];
}

-(void)FinishedAskingQuestions
{
    [self prepareAuthForLogin];
}

-(void)forgotPassFinished {
    [self prepareAuthForRestorePass];
}

-(void) showRegisterDeviceAlert
{
  //  UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
  //  [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [question.DefaultAnswers objectAtIndex:1];
    
    question = [[IGMobileApp sharedInstance].currentAuthenticationResponse.pendingActionRequest.questions objectAtIndex:0];
    
    acceptRegisterDeviceAnswer = [question.DefaultAnswers objectAtIndex:0];
    declineRegisterDeviceAnswer = [question.DefaultAnswers objectAtIndex:1];
    
    
    
    UIAlertView *registerDeviceAlert = [[UIAlertView alloc] initWithTitle:question.text message:OM_ALERT_REGISTERDEVICE_ALERTMESSAGE delegate:self cancelButtonTitle:declineRegisterDeviceAnswer.text otherButtonTitles:acceptRegisterDeviceAnswer.text, nil];
    
    registerDeviceAlert.tag = 10;
    
    [IGMobileApp sharedInstance].currentAnswer = declineRegisterDeviceAnswer;
    [IGMobileApp sharedInstance].currentAnswer.questionId = question.questionId;
    
  //  [self hideHud:window];
    [self createAuthRequestForRegisterDevice];
    
    //[registerDeviceAlert show];
    
}

//Handle register device alert actions
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 10){
        if (buttonIndex == [alertView cancelButtonIndex]) {
            //cancel
            [IGMobileApp sharedInstance].currentAnswer = declineRegisterDeviceAnswer;
            
        } else {
            //register device
            [IGMobileApp sharedInstance].currentAnswer = acceptRegisterDeviceAnswer;
        }
        
        [IGMobileApp sharedInstance].currentAnswer.questionId = question.questionId;
        
        [self createAuthRequestForRegisterDevice];
        
    }else if (alertView.tag == 11){
        [[IGLocalStorageService sharedInstance] save:@"False" To:@"firstTime"];
    }

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"TermsAndConditions"]){
        OMTermsAndConditionsViewController *destVc = segue.destinationViewController;
        destVc.delegate = self;
        
    }else if ([segue.identifier isEqualToString:@"registerQuestionsSegue"]){
        OMRegisterQuestionsViewController *destVc1 = segue.destinationViewController;
        destVc1.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"askQuestionsSegue"]){
        IGAskQuestionsViewController *destVc2 =  segue.destinationViewController;
        destVc2.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"restorePassSegue"]){
        IGRestorePassFirstScreenViewController *destVc3 = segue.destinationViewController;
        destVc3.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"restorePassQuestionsSegue"]){
        IGRestorePassQuestionsViewController *destVc4 = segue.destinationViewController;
        destVc4.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"showWebViewSegue"]){
        OMWebViewController *webViewController = segue.destinationViewController;
        webViewController.urlString = url;
        webViewController.titleString = titleText;
    }
}

-(void) prepareAuthForLogin
{
    self.authRequest = [IGMobileApp sharedInstance].currentAuthenticationRequest;
    [self attemptLogin];
}

-(void) prepareAuthForRestorePass
{
    self.forgotPassRequest = [IGMobileApp sharedInstance].forgotPasswordRequest;
    [self attemptLoginForRestorePass];
}

-(void)attemptLogin
{
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    indicator.layer.cornerRadius = 5;
    indicator.layer.masksToBounds = YES;
    indicator.backgroundColor =  UIColor.lightGrayColor;
    indicator.alpha = 0.5;
    indicator.color = UIColor.blackColor;
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    
    [indicator startAnimating];
    
   // UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
  //  [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    //showcon = [ShowControllsController new];
    
    //uview = [showcon showFuctionWithView:self];
    
    self.view.userInteractionEnabled = NO;
    [[IGMobileApp sharedInstance] login:self.authRequest withBlock:^(NSError *error) {
        
        if(!error) {
            
            self.txtLogin.text = IGEmptyString;
            self.txtPassword.text = IGEmptyString;
            
            IGAuthenticationResponse *currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
            
            
            //[showcon hideFuctionWithView:uview];
            self.view.userInteractionEnabled = YES;
            if ([IGMobileApp sharedInstance].currentNewPassword && currentAuthResponse.pendingActionRequest.pendingActionType != 1 && lastPendingAction == 1) {
                [IGMobileApp sharedInstance].currentAuthenticationRequest.password = [IGMobileApp sharedInstance].currentNewPassword;
            }
            
            if (currentAuthResponse.pendingActionRequest == nil && currentAuthResponse.token != nil &&
                currentAuthResponse.authenticationStatus == 1) {
                
                RequestSwiftObjC *Object = [RequestSwiftObjC alloc];
                [Object GetLOCALLOGINWithCedula:currentAuthResponse.docNumber tipo:currentAuthResponse.docType];
                GlobalVarFunc *Global = [GlobalVarFunc alloc];
                
                [Global SetTokenWithToken:currentAuthResponse.token];
                
                [self setToken:currentAuthResponse];
                [indicator stopAnimating];
               // [self hideHud:window];
                if (IPHONE)
                {
                    [self performSegueWithIdentifier:@"showBalancesSegue" sender:nil];
                }
                else
                {
                    [self performSegueWithIdentifier:@"showBalancesSegue" sender:nil];
                }
                return;
                
            }
            
            //Is there any error ?
            if (currentAuthResponse.authenticationStatus == 0 && currentAuthResponse.pendingActionRequest == nil) {
                //[self hideHud:window];
                [indicator stopAnimating];
                [self showAlertError:currentAuthResponse.authenticationMessage];
                [self clearControls];
                return;
            }
            
            if (currentAuthResponse.pendingActionRequest != nil) {
                if (lastPendingAction == 1 && currentAuthResponse.pendingActionRequest.pendingActionType != 1) {
                    
                    UIAlertView *registerDeviceAlert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_ALERT_REGISTERDEVICE_SUCCESSCHANGE delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
                    
                    [registerDeviceAlert show];
                }
                
            //   [self hideHud:window];
                [indicator stopAnimating];
                [self redirectToAction:currentAuthResponse.pendingActionRequest];
            }
            
            
            
        } else {
            //[showcon hideFuctionWithView:uview];
          //  [self hideHud:window];
             self.view.userInteractionEnabled = YES;
            [indicator stopAnimating];
            [self showAlertError:OM_MESSAGE_LOGIN_ERRORONSERVICE];
            [self clearControls];
            
        }
    }];
}

-(void) setToken:(IGAuthenticationResponse *)autenticationResponse{
    
    NSString *token = [NSString stringWithFormat:@"Basic %@", autenticationResponse.token];
    [[IGAPIClient sharedInstance] setAuthorizationToken:token];
    
}

-(void)attemptLoginForRestorePass
{
  //  UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
  //  [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[IGMobileApp sharedInstance] loginForRestorePass:self.forgotPassRequest withBlock:^(NSError *error) {
        
        if(!error) {
            
            IGForgotPasswordResponse *currentForgotPassResponse = [IGMobileApp sharedInstance].forgotPasswordResponse;
            
            //Is there any error ?
            if (currentForgotPassResponse.pendingActionRequest.failAttempts != 0) {
                
           //     [self hideHud:window];
                [self showAlertError:currentForgotPassResponse.message];
                [self clearControls];
            }
            else if (currentForgotPassResponse.pendingActionRequest == nil &&
                     currentForgotPassResponse.status == 1) {
            //    [self hideHud:window];
                [self performSegueWithIdentifier:@"restorePassConfirmationSegue" sender:nil];
            }
            else if (currentForgotPassResponse.status == 0 && currentForgotPassResponse.pendingActionRequest == nil) {
            //    [self hideHud:window];
                [self showAlertError:currentForgotPassResponse.message];
                [self clearControls];
            }
            
            else  {
         //       [self hideHud:window];
                [self showAlertError:currentForgotPassResponse.message];
                [self performSegueWithIdentifier:@"restorePassQuestionsSegue" sender:nil];
            }
        } else {
          //  [self hideHud:window];
            [self showAlertError:OM_MESSAGE_LOGIN_ERRORONSERVICE];
            [self clearControls];
            
        }
    }];
}

-(void) hideHud:(UIWindow *)actualWindow {
    [MBProgressHUD hideHUDForView:actualWindow animated:YES];
}

-(void) hideChangePassPopUpwithBlock:(void (^)(NSError *error))block {
    
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        block(nil);
    }];
}

-(void) showAlertError:(NSString *)errorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT
                                                    message:errorMessage
                                                   delegate:nil
                                          cancelButtonTitle:OM_TXT_ACCEPT
                                          otherButtonTitles:nil];
    [alert show];
}

-(void) showChangePasswordDialog
{
    
    OMChangePasswordViewController *changePasswordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordController"];
    
    changePasswordViewController.delegate = self;
    
    // present form sheet with view controller
    [self mz_presentFormSheetWithViewController:changePasswordViewController animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        formSheetController.shouldDismissOnBackgroundViewTap = NO;
        
    }];
}

-(void) showTermsAndConditionsDialog
{
    [self performSegueWithIdentifier:@"TermsAndConditions"sender:nil];
}

-(void) showSecurityQuestions
{
    [self performSegueWithIdentifier:@"registerQuestionsSegue" sender:nil];
}

-(void) showAskQuestions
{
    [self performSegueWithIdentifier:@"askQuestionsSegue" sender:self];
}

-(void) createAuthRequestForRegisterDevice
{
    
    IGAuthenticationResponse *currentAuthResponse = [IGMobileApp sharedInstance].currentAuthenticationResponse;
    IGPendingActionResponse *pendingResponse = [[IGPendingActionResponse alloc] init];
    IGAnswer *userAnswer = [[IGAnswer alloc] init];
    
    //Pending action response
    pendingResponse.name = currentAuthResponse.pendingActionRequest.name;
    pendingResponse.failedAttempts = currentAuthResponse.pendingActionRequest.failAttempts;
    pendingResponse.type = currentAuthResponse.pendingActionRequest.pendingActionType;
    
    //User answer
    userAnswer.questionId = [IGMobileApp sharedInstance].currentAnswer.questionId;
    userAnswer.answerId = [IGMobileApp sharedInstance].currentAnswer.answerId;
    userAnswer.text = nil;
    answers = [NSArray arrayWithObject:userAnswer];
    
    pendingResponse.answers = answers;
    [IGMobileApp sharedInstance].currentAuthenticationRequest.deviceNumber = [IGMobileApp sharedInstance].appUniqueIdentifier;
    //[IGMobileApp sharedInstance].currentAuthenticationRequest.deviceNumber = @"ip1";
    [IGMobileApp sharedInstance].currentAuthenticationRequest.pendingActionResponse = pendingResponse;
    
    [self prepareAuthForLogin];
}

-(void)redirectToAction:(IGPendingActionRequest *)pendingRequest
{
    switch (pendingRequest.pendingActionType) {
        case ChangePassword:
            lastPendingAction = 1;
            [self showChangePasswordDialog];
            break;
            
        case TermsAndConditions:
            lastPendingAction = 0;
            [self showTermsAndConditionsDialog];
            break;
            
        case SecurityQuestions:
            lastPendingAction = 0;
            if(pendingRequest.name == nil){
                [self showAlertError:pendingRequest.message];
                [self clearControls];
                return;
            }
            if ([pendingRequest.name isEqualToString:IG_PENDING_ACTION_NAME_VALIDATE]){
                [self showAskQuestions];
            } else if ([pendingRequest.name isEqualToString:IG_PENDING_ACTION_NAME_REGISTER]) {
                [self showSecurityQuestions];
            }
            break;
            
        case RegisterDevice:
            lastPendingAction = 0;
            [self showRegisterDeviceAlert];
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.txtLogin) {
        [textField resignFirstResponder];
        [self.txtPassword becomeFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}

#pragma mark - UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0 ... 1:
            titleText = [titleItem objectAtIndex:indexPath.row];
            url = [webItem objectAtIndex:indexPath.row];
            [self performSegueWithIdentifier:@"showWebViewSegue" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"channelGuideViewSegue" sender:self];
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    static NSString *CellIdentifier = @"Cell";
    IGLoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[IGLoginTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.imageItemImageView.image = [UIImage imageNamed:[imageItem objectAtIndex:indexPath.row]];
    cell.titleItemLabel.text = [titleItem objectAtIndex:indexPath.row];
    cell.descriptionItemLabel.text = [descriptionItem objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDatasource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [imageItem count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath {
    return 60;
}

- (void)showProfitabilityView:(UITapGestureRecognizer *)gesture {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@"Rentabilidades" value:0] build]];
    titleText = @"Rentabilidades";
    
    url = @"https://portal.oldmutual.com.co/om.rentabilidades.pl/oldmutual";
    [self performSegueWithIdentifier:@"showWebViewSegue" sender:self];
}

- (void)showSimulatorView:(UITapGestureRecognizer *)gesture {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@"Simuladores" value:0] build]];
    titleText = @"Simuladores";
    
    url = @"https://portal.oldmutual.com.co/sites/simuladores/index.php";
    [self performSegueWithIdentifier:@"showWebViewSegue" sender:self];
}

- (void)channelGuideView:(UITapGestureRecognizer *)gesture {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@" Canales de Contacto" value:0] build]];
    [self performSegueWithIdentifier:@"channelGuideViewSegue" sender:self];
}
- (IBAction)triRentabilidad:(id)sender {
    if (IPHONE) {
        titleText = titleItem[0];
        url = webItem[0];
        [self performSegueWithIdentifier:@"showWebViewSegue" sender:self];

    }
    else
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@"Rentabilidades" value:0] build]];
        titleText = @"Rentabilidades";
        
        url = @"https://portal.oldmutual.com.co/om.rentabilidades.pl/oldmutual";
        [self performSegueWithIdentifier:@"showWebViewSegue" sender:self];
        
        
    }
}

- (IBAction)triContacto:(UIButton *)sender {
    if (IPHONE)
    {
        [self performSegueWithIdentifier:@"channelGuideViewSegue" sender:self];
    }
    else
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@" Canales de Contacto" value:0] build]];
        [self performSegueWithIdentifier:@"channelGuideViewSegue" sender:self];
    }
}
- (IBAction)triSimuladores:(id)sender {
    if (IPHONE)
    {
        titleText = titleItem[1];
        url = webItem[1];
        [self performSegueWithIdentifier:@"showWebViewSegue" sender:self];
    }
    else
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Login" action:@"Touch" label:@"Simuladores" value:0] build]];
        titleText = @"Simuladores";
        
        url = @"https://portal.oldmutual.com.co/sites/simuladores/index.php";
        [self performSegueWithIdentifier:@"showWebViewSegue" sender:self];
        
        
    }
}
- (IBAction)triCertificacion:(id)sender {
    
    CallControllers *call = [CallControllers new];
    if (IPHONE)
    {
        [call PushCertificacionOfflineWithView:self];
    }
    else
    {
        [call PushCertificacionOfflineIpadWithView:self];
    }
    
    
}



@end
