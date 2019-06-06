//
//  OMDownloadStatementsViewController.h
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMDownloadStatementsViewController : UIViewController<UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) UIDocumentInteractionController* controller;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIWebView *ipadWebView;

@end
