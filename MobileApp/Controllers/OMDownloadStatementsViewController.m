
//
//  OMDownloadStatementsViewController.m
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMDownloadStatementsViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLSessionManager.h"
#import "IGMobileApp.h"
#import "IGAPIClient.h"
#import  "MBProgressHUD.h"
#import "IGTimeoutApplication.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface OMDownloadStatementsViewController () {
    NSString *filePath;
    UIBarButtonItem *shareButton;
    NSString *fileName;
}

@end

@implementation OMDownloadStatementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeHud)
                                                 name:kApplicationDidTimeoutNotification
                                               object:nil];
    
    shareButton = [[UIBarButtonItem alloc]
                   initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                   target:self
                   action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    if(IPAD) {
        
        if ([[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_EXTRACT] || [[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_CERTIFICATE]) {
            if ([self.splitViewController respondsToSelector:@selector(displayModeButtonItem)]) {
                self.navigationItem.leftBarButtonItem = [self.splitViewController displayModeButtonItem];
            }
        }
    }
    
    self.navigationController.navigationBar.tintColor = OM_COLOR_LIGHT_GREEN;
 
    [self downloadFile];
}

-(void)closeHud{

    [self hideHud:[[[UIApplication sharedApplication] windows] lastObject]];
}

-(void)shareAction{
    self.controller = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    
    CGRect navRect = self.navigationController.navigationBar.frame;
    navRect.size = CGSizeMake(1500.0f, 40.0f);
    self.controller.delegate = self;
    [self.controller presentOptionsMenuFromRect:navRect inView:self.view  animated:YES];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.view.frame;
}

-(void)downloadFile{
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode  = MBProgressHUDModeDeterminate;
    hud.labelText = @"Descargando archivo";
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if([[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_EXTRACT] || [[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_CERTIFICATE]) {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        if ([[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_EXTRACT]){
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Extractos" action:@"Descarga" label:@"Descarga - Extracto" value:0] build]];
        }else{
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Certificados Tributarios" action:@"Descarga" label:@"Descarga - Certificados Tributarios" value:0] build]];
        }
        
        fileName = [NSString stringWithFormat:@"%@_%@", [[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_CERTIFICATE]? @"certificado" : @"extracto" ,[IGMobileApp sharedInstance].currentSelectedStatement.periodId];
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", fileName]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            [[NSFileManager defaultManager] removeItemAtPath: filePath error:nil];
        }
        
        [[IGMobileApp sharedInstance] getDownloadDocument:[NSString stringWithFormat:@"%@", [IGAPIClient sharedInstance].baseURL] withPeriod:[IGMobileApp sharedInstance].currentSelectedStatement.periodId withDocType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withDocNumber:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber withReportType:[IGMobileApp sharedInstance].currentReportType andFilePath:filePath withBlock:^(id response, NSError *error) {
            
            [hud hide:YES];
            
            if(!error) {
                
                [self showDocument:filePath];
            } else {
                [self showErrorAlert];
            }
        }progress:^(float progress) {
             hud.progress = progress;
        }];
    }
    else if ([[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_TRANSACTION_DETAIL]) {
        
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Detalle de la Transacción" action:@"Descarga" label:@"Descarga - Documentos" value:0] build]];
        
        fileName = [IGMobileApp sharedInstance].currentSelectedTransactionsHistory.eventNumber;
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", fileName]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            [[NSFileManager defaultManager] removeItemAtPath: filePath error:nil];
        }
        
        [[IGMobileApp sharedInstance] postDownloadDocument:[NSString stringWithFormat:@"%@", [IGAPIClient sharedInstance].baseURL] withDocNumber:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber withDocType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withType:[IGMobileApp sharedInstance].currentSelectedDocumentHistoryDetail.documentType withProductCode:[IGMobileApp sharedInstance].currentSelectedTransactionsHistory.productCode withContract:[IGMobileApp sharedInstance].currentSelectedTransactionsHistory.contract withPlanCode:[IGMobileApp sharedInstance].currentSelectedTransactionsHistory.planCode withEventNumber:[IGMobileApp sharedInstance].currentSelectedTransactionsHistory.eventNumber withTransactionNumber: [IGMobileApp sharedInstance].currentSelectedTransactionsHistory.transactionNumber withEffectiveDate: [IGMobileApp sharedInstance].currentSelectedTransactionsHistory.effectiveDate withNetValue:[IGMobileApp sharedInstance].currentSelectedTransactionsHistory.netValue withDescription:[IGMobileApp sharedInstance].currentSelectedTransactionsHistory.descriptionText andFilePath:filePath withBlock:^(id response, NSError *error) {
            
            [hud hide:YES];
            
            
            if(!error) {
                
                [self showDocument:filePath];
            } else {
                [self showErrorAlert];
            }
        }progress:^(float progress) {
             hud.progress = progress;
        }];
        
       
            }
    else if([[IGMobileApp sharedInstance].currentDownloadDocumentType isEqualToString:OM_TXT_GENERATE_CERTIFICATE]){
        
        fileName = [NSString stringWithFormat:@"certificado_afiliacion_%@", [IGMobileApp sharedInstance].currentReportRequest.contract];
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", fileName]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            [[NSFileManager defaultManager] removeItemAtPath: filePath error:nil];
        }
        
            [[IGMobileApp sharedInstance] postDownloadDocumentCertificate:[IGMobileApp sharedInstance].currentReportRequest andFilePath:filePath withBlock:^(id response, NSError *error) {
                
                [hud hide:YES];
                
                if(!error) {
                    
                    [self showDocument:filePath];
                } else {
                    [self showErrorAlert];
                }
            }progress:^(float progress) {
                 hud.progress = progress;
            }];
            
        }
    }

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) showErrorAlert{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT
                                                    message:OM_MESSAGE_LOGIN_ERRORONSERVICE
                                                   delegate:nil
                                          cancelButtonTitle:OM_TXT_ACCEPT
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) hideHud:(UIWindow *)actualWindow {
    [MBProgressHUD hideHUDForView:actualWindow animated:YES];
}

- (void)showDocument:(NSString*)path {
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    if(IPHONE) {
        [self.webView setUserInteractionEnabled:YES];
        [self.webView loadRequest:requestObj];
    } else {
        [self.ipadWebView setUserInteractionEnabled:YES];
       [self.ipadWebView loadRequest:requestObj];
    }
}

@end
