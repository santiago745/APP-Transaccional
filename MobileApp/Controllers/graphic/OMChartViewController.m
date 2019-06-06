//
//  OMGraphicViewController.m
//  MobileApp
//
//  Created by Rober on 21/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMChartViewController.h"
#import "MZFormSheetController.h"
#import "IGMobileApp.h"
#import "IGGroup.h"
#import "IGContractDetailGroups.h"
#import "IGRecordValue.h"

@implementation OMChartViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *names = [[NSMutableArray alloc]init];
    NSMutableArray *porcentajes = [[NSMutableArray alloc]init];
    NSMutableArray *chartItems = [[NSMutableArray alloc]init];
    NSArray *chartColors = OM_ARRAY_COLORS;
    
    IGContractDetailGroups *groupField = [IGMobileApp sharedInstance].currentSelectedGroupsField;
    IGRecordValue *recordValue;
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = groupField.caption;
    
    for (int i = 0; i < [groupField.recordValue count]; i++) {
        
        NSArray *recordVal = [groupField.recordValue objectAtIndex:i];
        
        for (int j = 0; j < [[groupField.recordValue objectAtIndex:i] count]; j++) {
            recordValue = [MTLJSONAdapter modelOfClass:IGRecordValue.class fromJSONDictionary:[recordVal objectAtIndex:j] error:nil];
            
            if ([recordValue.caption isEqualToString:@"Fondo"]) {
                [names addObject:recordValue.value];
            }
            
            if ([recordValue.caption isEqualToString:@"Porcentaje"]) {
                [porcentajes addObject:recordValue.value];
            }
        }
    }
    
    for (int k = 0; k < [groupField.recordValue count]; k++) {
        [chartItems addObject:[PNPieChartDataItem dataItemWithValue:[[porcentajes objectAtIndex:k] floatValue] color:[chartColors objectAtIndex:k] description:[names objectAtIndex:k]]];
    }
    
    NSArray *items = [chartItems copy];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(80, 80, VIEW_WIDTH-150, VIEW_HEIGTH-150) items:items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    
    if ([items count] > 6) {
        self.pieChart.descriptionTextFont  = OM_FONT_HELVETICANEUE_MEDIUM;
    } else {
        self.pieChart.descriptionTextFont  = OM_FONT_HELVETICANEUE_BIG;
    }
    
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    
    [self.pieChart strokeChart];
    
    [self.view addSubview:self.pieChart];
}

- (IBAction)closeButton:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
    }];
    [self.pieChart clearView];
}

@end
