//
//  OMAgentsDetailViewController.h
//  MobileApp
//
//  Created by Rober on 17/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface OMAgentsDetailViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *emailTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPhoneTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *agencyAddressTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *agencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *agencyAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *emailButtonWhitText;
@property (weak, nonatomic) IBOutlet UIButton *cellPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *cellPhoneButtonWhitText;
@property (weak, nonatomic) IBOutlet UIButton *phoneButtonWhitText;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;


- (IBAction)sendEmail:(id)sender;
- (IBAction)makeCallCellPhone:(id)sender;

@end
