//
//  OMGenerateCertificateViewController.h
//  MobileApp
//
//  Created by Rober on 19/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMGenerateCertificateViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, weak) id delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)sendButton:(id)sender;

@end
