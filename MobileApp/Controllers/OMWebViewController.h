//
//  OMWebViewController.h
//  MobileApp
//
//  Created by Rober on 5/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *urlString;
@property (nonatomic) NSString *titleString;
- (IBAction)closePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
