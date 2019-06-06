//
//  IGShowRegisteredQuestionsViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/18/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMShowRegisteredQuestionsViewController.h"
#import "IGMobileApp.h"
#import "IGQuestion.h"

@interface OMShowRegisteredQuestionsViewController () {
    NSArray *selectedQuestions;
    IGQuestion *singleQuestion;
    UIFont *cellFont;
    UIView *bgSelectedCellColorView;
}

@end

@implementation OMShowRegisteredQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellFont = OM_FONT_ARIAL_BIG;
    bgSelectedCellColorView = [[UIView alloc] init];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    self.title = OM_TXT_ASK_QUESTION;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
    [self setTexts];
    
    //show selected questions
    selectedQuestions = [[NSArray alloc]initWithArray:[IGMobileApp sharedInstance].selectedQuestions];
    
    singleQuestion = [[IGQuestion alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTexts{
    self.lblIntructions.text = OM_LABEL_SHOWREGISTEREDQUESTIONS_INSTRUCTIONS;
    self.lblTitle.text = OM_DEAR_CLIENT;
    [self.btnEnd setTitle:OM_TXT_CLOSE forState:UIControlStateNormal] ;
    
}

-(IBAction)backButtonPressed:(id)sender{
    [self displayCancelAlert];
}

-(void) displayCancelAlert
{
    UIAlertView *cancelQuestionsAlert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_ALERT_REGISTERQUESTION_CANCELQUESTIONS_MESSAGE delegate:self cancelButtonTitle:OM_TXT_CANCEL otherButtonTitles:OM_TXT_ACCEPT, nil];
    
    [cancelQuestionsAlert show];
}

//Handle register device alert actions
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        //cancel
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [selectedQuestions count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"questionsCell"  forIndexPath:indexPath];
    
    singleQuestion = [selectedQuestions objectAtIndex:indexPath.item];
    cell.textLabel.text = singleQuestion.text;
    cell.textLabel.font = cellFont;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor colorWithRed:48.0f/255.0f green:48.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_num_%d", indexPath.row + 1]];
    bgSelectedCellColorView.backgroundColor = OM_COLOR_LIGHT_GREEN;
    [cell setSelectedBackgroundView:bgSelectedCellColorView];
    return cell;
}

- (IBAction)btnClicked {
    if ([self.delegate respondsToSelector:@selector(finishedRegisteringQuestions)]) {
        [self.delegate finishedRegisteringQuestions];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
