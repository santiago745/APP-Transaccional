//
//  IGShowRegisteredQuestionsViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/18/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FinishedRegisteringQuestionsDelegate<NSObject>

@required

-(void) finishedRegisteringQuestions;
@end



@interface OMShowRegisteredQuestionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblIntructions;
@property (weak, nonatomic) IBOutlet UIButton *btnEnd;

@property (nonatomic, weak) id<FinishedRegisteringQuestionsDelegate> delegate;

- (IBAction)btnClicked;
@end
