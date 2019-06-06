//
//  IGAskQuestionsViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/20/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@protocol FinishedAskingQuestionsDelegate <NSObject>

@required
-(void) FinishedAskingQuestions;
@end

@interface IGAskQuestionsViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, weak) id<FinishedAskingQuestionsDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblFirstQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblSecondQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblIntructions;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnEnd;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstQuestion;
@property (weak, nonatomic) IBOutlet UITextField *txtSecondQuestion;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *myScrollView;

- (IBAction)finish:(id)sender;

@end
