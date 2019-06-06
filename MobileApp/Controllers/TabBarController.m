//
//  TabBarController.m
//  MobileApp
//
//  Created by steven muñoz on 22/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "TabBarController.h"
#import "IGMobileApp.h"
#import "OMBlankViewController.h"
#import "OMAgentsViewController.h"
#import "OMChannelGuideViewController.h"
#import "MZFormSheetController.h"
#import "OMWebViewController.h"
#import "SWRevealViewController.h"

@implementation TabBarController


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"1-%@", @"Retiros_en_el_Acceso_rápido"],
                                     kFIRParameterItemName:@"Retiros_en_el_Acceso_rápido",
                                     kFIRParameterContentType:@"image"
                                     }];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    UIImage *selectedImage;
    
    if([item.title isEqualToString:OM_TXT_BALANCE]) {
        [self sendNotification:0];
        selectedImage = [UIImage imageNamed:@"icon_balance_green"];
    } else if ([item.title isEqualToString:OM_TXT_CERTIFICATE]) {
        [self sendNotification:1];
        selectedImage = [UIImage imageNamed:@"icon_certificate_green"];
        [IGMobileApp sharedInstance].currentReportType = @"2";
        [IGMobileApp sharedInstance].currentDownloadDocumentType = OM_TXT_CERTIFICATE;
    } else if ([item.title isEqualToString:OM_TXT_EXTRACT]) {
        [self sendNotification:2];
        selectedImage = [UIImage imageNamed:@"icon_extract_green"];
        [IGMobileApp sharedInstance].currentReportType = @"1";
        [IGMobileApp sharedInstance].currentDownloadDocumentType = OM_TXT_EXTRACT;
    } else if ([item.title isEqualToString:OM_TXT_AGENT]) {
        [self sendNotification:3];
        selectedImage = [UIImage imageNamed:@"icon_agent_green"];
    } else if ([item.title isEqualToString:OM_TXT_CONTRACT]) {
        selectedImage = [UIImage imageNamed:@"icon_contract_detail_green"];
    } else if ([item.title isEqualToString:OM_TXT_HISTORICAL]) {
        selectedImage = [UIImage imageNamed:@"icon_historical_green"];
    } else if ([item.title isEqualToString:OM_TXT_GENERATE_CERTIFICATE]) {
        selectedImage = [UIImage imageNamed:@"icon_certificate_green"];
    }
    
    [item setSelectedImage: selectedImage];
}

-(void) sendNotification:(NSUInteger) itemSelected{
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTvIndexNotification" object:self userInfo:@{@"index": @(itemSelected)}];
    

}

-(void) viewDidLoad{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeIndex:)
                                                 name:@"ChangeIndexNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showChannelGuide:)
                                                 name:@"ShowChannelGuide"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showWebView:)
                                                 name:@"ShowWebView"
                                               object:nil];

}

-(void) changeIndex:(NSNotification*)notification{
    
    
    NSNumber *pos = (NSNumber*)notification.userInfo[@"index"];
    if([pos integerValue] == 1){
        [IGMobileApp sharedInstance].currentReportType = @"2";
         [IGMobileApp sharedInstance].currentDownloadDocumentType = OM_TXT_CERTIFICATE;
    }else if ([pos integerValue] == 2){
        [IGMobileApp sharedInstance].currentReportType = @"1";
        [IGMobileApp sharedInstance].currentDownloadDocumentType = OM_TXT_EXTRACT;
    }else if ([pos integerValue] == 3){
    }
    [self setSelectedViewController:[self.viewControllers objectAtIndex:[pos integerValue]]];
    
}

- (void) showChannelGuide:(NSNotification*)notification{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Authentication" bundle: nil];
    OMChannelGuideViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"OMChannelGuideViewController"];
    [[self navigationController] pushViewController:vc animated:YES];

    /*UIStoryboard * storyBoardAut = [UIStoryboard storyboardWithName:@"Authentication" bundle:nil];    OMChannelGuideViewController *chartViewController = [storyBoardAut instantiateViewControllerWithIdentifier:@"OMChannelGuideViewController"];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:chartViewController];
    
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheet.portraitTopInset = 0;
    formSheet.landscapeTopInset = 0;
    if (IPAD){
        formSheet.presentedFormSheetSize = CGSizeMake(VIEW_WIDTH_TABLET, VIEW_HEIGTH_TABLET);
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
     formSheet.presentedFormSheetSize = CGSizeMake(screenWidth, screenHeight);
    }
    
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) { }];*/

}

- (void) showWebView:(NSNotification*)notification{
    
    
    OMWebViewController *chartViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:chartViewController];
    
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheet.portraitTopInset = 0;
    formSheet.landscapeTopInset = 0;
    if (IPAD){
        formSheet.presentedFormSheetSize = CGSizeMake(VIEW_WIDTH_TABLET, VIEW_HEIGTH_TABLET);
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        formSheet.presentedFormSheetSize = CGSizeMake(screenWidth, screenHeight);
    }
    
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) { }];
   
}

-(void)viewWillAppear:(BOOL)animated {
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

@end
