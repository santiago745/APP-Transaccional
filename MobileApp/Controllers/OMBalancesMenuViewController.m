//
//  OMBalancesMenuViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/30/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMBalancesMenuViewController.h"
#import "IGTimeoutApplication.h"
#import "IGMobileApp.h"
#import "IGTimeoutApplication.h"
#import <QuartzCore/QuartzCore.h>
#import "OMWebViewController.h"
#import "TabBarController.h"
#import "SWRevealViewController.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "MobileApp-Swift.h"
#import "OMChannelGuideViewController.h"

@interface OMBalancesMenuViewController ()
    @property (nonatomic, strong) NSArray *menuItems;
    @property (nonatomic, strong) NSArray *menuItemsImages;

@end

@implementation OMBalancesMenuViewController{
    NSString *url;
    NSString *titleText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeIndex:)
                                                 name:@"ChangeTvIndexNotification"
                                               object:nil];
        _menuItems = @[@"Saldos Consolidados", @"Certificados Tributarios", @"Consulta de Extractos", @"Rentabilidades", @"Simuladores", @"Canales de Contacto"];
        _menuItemsImages = @[@"icon_balance_white", @"icon_certificate_white", @"icon_extracts_white", @"icon_profitability_white", @"icon_simulators_white", @"icon_channel_white"];
    
    // Do any additional setup after loading the view.
//    self.tvMenu.backgroundColor = IG_LEFT_MENU_CELL_BACKGROUND_COLOR;
        [self.tvMenu setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self.tvMenu setSeparatorColor:[UIColor whiteColor]];
        self.tvMenu.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.lblLastSession.text = [NSString stringWithFormat:@"Su último ingreso fue: %@", [[IGMobileApp sharedInstance] currentAuthenticationResponse].lastAccess];
    self.lblCurrentIP.text = [self getCurrentIPText];
    self.lblClientName.text = [[IGMobileApp sharedInstance]currentAuthenticationResponse].user.name;
}

-(void) changeIndex:(NSNotification*)notification{
    
    
     NSNumber *pos = (NSNumber*)notification.userInfo[@"index"];
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[pos integerValue] inSection:0];
    [self.tvMenu selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

-(NSString*)getCurrentIPText{
    NSString* currentIPAddress = [[IGMobileApp sharedInstance]appCurrentIPAddress];
    return [NSString stringWithFormat:OM_TXT_LABEL_IP,currentIPAddress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnSaveExit:(UIButton *)sender {
    RequestSwiftObjC *Object = [RequestSwiftObjC alloc];
    [Object GetCleanLogin];
    [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
               [tableView setLayoutMargins:UIEdgeInsetsZero];
                [cell setLayoutMargins:UIEdgeInsetsZero];
                cell.preservesSuperviewLayoutMargins = NO;
            }
    
        cell.backgroundColor = IG_LEFT_MENU_CELL_BACKGROUND_COLOR;
        cell.contentView.backgroundColor = IG_LEFT_MENU_CELL_BACKGROUND_COLOR;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = IG_LEFT_MENU_CELL_HIGHLIGHTEDTEXT_COLOR;
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor whiteColor];
        [cell setSelectedBackgroundView:bgColorView];
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        // Return the number of rows in the section.
        return [_menuItems count];
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        NSString *cellIdentifier = [_menuItems objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [_menuItems objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[_menuItemsImages objectAtIndex:indexPath.row]];
    cell.imageView.tintColor = [UIColor whiteColor];
        return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.revealViewController revealToggle:self];
    if (indexPath.row == 3){
        [self showProfitabilityView];
    }else if (indexPath.row == 4){
        [self showSimulatorView];
    }
    if (indexPath.row == 5){
        [self showChannelGuide];
    }
    if (indexPath.row != 5 && indexPath.row != 4 && indexPath.row != 3){
        [self changeTabBarIndex:indexPath.row];
    }

   
}

-(void) showChannelGuide{

    if (IPHONE)
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Menú principal" action:@"Touch" label:@"Canales de Contacto" value:0] build]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowChannelGuide" object:self];
    
    }
    else
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AuthenticationIpad" bundle:nil];
        OMChannelGuideViewController *documetController       = [sb instantiateViewControllerWithIdentifier:@"OMChannelGuideViewController"];
        documetController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        documetController.Logueado = YES;
        [self presentModalViewController:documetController animated:YES];
    }
    
    
    
}

- (void) changeTabBarIndex:(NSUInteger)index{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeIndexNotification" object:self userInfo:@{@"index": @(index)}];
    
    
}

- (void)showProfitabilityView
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Menú principal" action:@"Touch" label:@"Rentabilidades" value:0] build]];
    
    [IGMobileApp sharedInstance].currentUrl = @"https://portal.oldmutual.com.co/om.rentabilidades.pl/oldmutual";
    [IGMobileApp sharedInstance].currentTitle = @"Rentabilidades";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowWebView" object:self];
    
    
}

- (void)showSimulatorView
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Menú principal" action:@"Touch" label:@"Simuladores" value:0] build]];
    
    [IGMobileApp sharedInstance].currentUrl = @"https://portal.oldmutual.com.co/sites/simuladores/index.php";
    [IGMobileApp sharedInstance].currentTitle = @"Simuladores";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowWebView" object:self];
   
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
//    if ([segue.identifier isEqualToString:@"showWebViewSegue"]){
//        OMWebViewController *webViewController = segue.destinationViewController;
//        webViewController.urlString = url;
//        webViewController.titleString = titleText;
//    }
}

@end
