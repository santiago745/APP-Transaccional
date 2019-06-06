//
//  IGRestorePassFirstScreenViewController.m
//  MobileApp
//
//  Created by steven muñoz on 30/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGRestorePassFirstScreenViewController.h"
#import "IGRestorePassViewController.h"

@interface IGRestorePassFirstScreenViewController ()

@end

@implementation IGRestorePassFirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    self.title = OM_TXT_RESTORE_PASSWORD;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)forgotPassFinished
{
    if ([self.delegate respondsToSelector:@selector(forgotPassFinished)]) {
        [self.delegate forgotPassFinished]; 
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"restorePassFormSegue"]){
        IGRestorePassViewController *destVc = segue.destinationViewController;
        destVc.delegate = self;

    }
}

@end
