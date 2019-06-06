//
//  OMAgentsDetailViewController.m
//  MobileApp
//
//  Created by Rober on 17/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMAgentsDetailViewController.h"
#import "IGMobileApp.h"
#import "IGAgent.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface OMAgentsDetailViewController ()

@end

@implementation OMAgentsDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    self.title = OM_TXT_AGENT_DETAIL_TITLE;
    
    if(IPHONE) {
        UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(saveExit)];
        
        self.navigationItem.rightBarButtonItem = saveExitButtonItem;
    }
    
    self.navigationItem.leftItemsSupplementBackButton = true;
    
    if ([self.splitViewController respondsToSelector:@selector(displayModeButtonItem)]) {
        self.navigationItem.leftBarButtonItem = [self.splitViewController displayModeButtonItem];
    }
    
    self.navigationController.navigationBar.tintColor = OM_COLOR_LIGHT_GREEN;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
    [self getAgent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveExit{
    [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) getAgent
{
    UIImage *image;
    if (IPHONE) {
        image = [UIImage imageNamed:@"image_pers"];
    }else{
        image = [UIImage imageNamed:@"image_pers_ipad"];
    }
    
    IGAgent *agent = [IGMobileApp sharedInstance].currentSelectedAgent;
    
    self.emailTextLabel.textColor = OM_COLOR_NEW_GREEN;
    self.cellPhoneTextLabel.textColor = OM_COLOR_NEW_GREEN;
    self.phoneTextLabel.textColor = OM_COLOR_NEW_GREEN;
    self.agencyAddressTextLabel.textColor = OM_COLOR_NEW_GREEN;
    
    self.nameLabel.textColor = OM_COLOR_NEW_GREEN;
    self.nameLabel.text = agent.name;
    [self.cellPhoneButtonWhitText setTitleColor:OM_COLOR_GRAY forState:UIControlStateNormal];
    [self.cellPhoneButtonWhitText setTitle:agent.cellPhone forState:UIControlStateNormal];
    [self.phoneButtonWhitText setTitleColor:OM_COLOR_GRAY forState:UIControlStateNormal];
    [self.phoneButtonWhitText setTitle:agent.phone forState:UIControlStateNormal];
    [self.emailButtonWhitText setTitleColor:OM_COLOR_GRAY forState:UIControlStateNormal];
    [self.emailButtonWhitText setTitle:agent.email forState:UIControlStateNormal];
    self.agencyNameLabel.textColor = OM_COLOR_GRAY;
    self.agencyNameLabel.text = agent.agencyName;
    self.agencyAddressLabel.textColor = OM_COLOR_GRAY;
    self.agencyAddressLabel.text = agent.agencyAddress;
    
    if (agent.email && ![agent.email isEqualToString:IGEmptyString]) {
        [self.emailButtonWhitText setEnabled:YES];
        [self.emailButton setHidden:NO];
    } else {
        [self.emailButtonWhitText setEnabled:NO];
        [self.emailButton setHidden:YES];
    }
    
    if (agent.cellPhone && ![agent.cellPhone isEqualToString:IGEmptyString] && IPHONE) {
        [self.cellPhoneButtonWhitText setEnabled:YES];
        [self.cellPhoneButton setHidden:NO];
    } else {
        [self.cellPhoneButtonWhitText setEnabled:NO];
        [self.cellPhoneButton setHidden:YES];
    }
    
    if (agent.photo && ![agent.photo isEqualToString:IGEmptyString]) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:agent.photo]
                           placeholderImage:image
                                    options:SDWebImageRefreshCached];
    } else {
        [self.photoImage setImage:image];
    }
}

- (IBAction)sendEmail:(id)sender {
    
    [self SendEmailFunc];
}

- (void) SendEmailFunc
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Mi Agente" action:@"Touch" label:@"Enviar email" value:0] build]];
    
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    if (controller == nil) {
        return;
    }
    controller.mailComposeDelegate = self;
    NSString *emailAddress = self.emailButtonWhitText.currentTitle;
    [controller setToRecipients:[NSArray arrayWithObject:emailAddress]];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)makeCallCellPhone:(id)sender {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Mi Agente" action:@"Touch" label:@"Llamar" value:0] build]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"tel:%@", self.cellPhoneButtonWhitText.currentTitle]]];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error
{
    if (result == MFMailComposeResultSent) {
        [self showAlert:OM_ALERT_TITLE_SEND_EMAIL message:OM_ALERT_MESSAGE_SEND_EMAIL];
    }
    else if (result == MFMailComposeResultFailed) {
        [self showAlert:OM_DEAR_CLIENT message:[NSString stringWithFormat:OM_ALERT_MESSAGE_SEND_EMAIL_ERROR, [error description]]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) showAlert:(NSString *)title
          message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:OM_TXT_ACCEPT
                                          otherButtonTitles:nil];
    [alert show];
}

@end
