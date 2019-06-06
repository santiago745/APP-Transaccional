//
//  OMTermsAndConditionsViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/17/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TermsAndConditionsAcceptedDelegate<NSObject>

@required

-(void) termsAccepted;
@end

@interface OMTermsAndConditionsViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, weak) id<TermsAndConditionsAcceptedDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextView *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAccept;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnReject;

- (IBAction)AcceptTerms:(id)sender;
- (IBAction)RejectTerms:(id)sender;

@end
