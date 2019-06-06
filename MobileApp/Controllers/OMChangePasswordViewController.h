//
//  OMChangePasswordViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/17/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordChangedDelegate<NSObject>

@required

-(void) passwordChanged;
@end

@interface OMChangePasswordViewController : UIViewController

@property (nonatomic, weak) id<PasswordChangedDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextView *txtChangePassword;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;


- (IBAction)btnAccept:(id)sender;
- (IBAction)btnCancel:(id)sender;

@end
