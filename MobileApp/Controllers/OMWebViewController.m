//
//  OMWebViewController.m
//  MobileApp
//
//  Created by Rober on 5/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMWebViewController.h"
#import "IGMobileApp.h"
#import "MZFormSheetController.h"
#import "IGTimeoutApplication.h"

@interface OMWebViewController ()

@end

@implementation OMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [(IGTimeoutApplication *)[UIApplication sharedApplication] invalidateTimer];
    
    self.navigationController.navigationBar.topItem.title = IGEmptyString;
    self.title = self.titleString;
    [self.navigationController.navigationBar setTintColor:OM_COLOR_LIGHT_GREEN];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    //Habilita el boton back
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    NSURL *url;
    //Create a URL object.
    if(self.urlString){
        url = [NSURL URLWithString:self.urlString];
    }else{
        url =  [NSURL URLWithString:[IGMobileApp sharedInstance].currentUrl];
    }
    if(self.titleString){
        self.titleLabel.text = self.titleString;
    }else{
        self.titleLabel.text = [IGMobileApp sharedInstance].currentTitle;
    }
    
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closePopup:(id)sender {    
    
    [(IGTimeoutApplication *)[UIApplication sharedApplication] resetIdleTimer];
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
    }];
}
-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
        
}
@end
