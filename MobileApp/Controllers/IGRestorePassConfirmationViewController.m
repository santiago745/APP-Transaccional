//
//  IGRestorePassConfirmationViewController.m
//  MobileApp
//
//  Created by steven muñoz on 20/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGRestorePassConfirmationViewController.h"

@interface IGRestorePassConfirmationViewController ()

@end

@implementation IGRestorePassConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.title = OM_TXT_RESTORE_PASSWORD;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];

}
- (IBAction)backToLogin:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
