//  IGSalesforceApp.m
//  salesforce
//
//  Created by Armando Restrepo on 11/25/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGMobileApp.h"
#import "IGRepositoryLocator.h"
//#import "IGLocalStorageService.h"
//#import "IGFormatHelper.h"
#import "IGAuthenticationRequest.h"
#import "IGError.h"
#import "IGNetworkHelper.h"
#import "IGAPIClient.h"

@interface IGMobileApp()

//Settings
@property (nonatomic, strong) NSDictionary *settings;

@end

@implementation IGMobileApp
{
    //Local fields
    NSUInteger currentPage;
}

IGRepositoryLocator *context;

static id _sharedInstance;

+ (IGMobileApp *) sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[self alloc] init];
        
    });
    
    return _sharedInstance;
}

-(NSString*)appUniqueIdentifier{
    if (!_appUniqueIdentifier) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"ApplicationUniqueIdentifier"] ){
            
            _appUniqueIdentifier = [[NSUUID UUID]UUIDString];
            
            [defaults setObject:_appUniqueIdentifier forKey:@"ApplicationUniqueIdentifier"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            _appUniqueIdentifier = [defaults objectForKey:@"ApplicationUniqueIdentifier"];
        }
    }
    
    
    return _appUniqueIdentifier;
    
}

-(NSString*)appCurrentIPAddress{
    _appCurrentIPAddress = [IGNetworkHelper getCurrentIPAddress];
    
    return _appCurrentIPAddress;
    
}

-(NSString*)appCurrentDateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    _appCurrentDateTime = [dateFormatter stringFromDate:[NSDate date]];
    return _appCurrentDateTime;
}


- (id) init {
    
    if (_sharedInstance) {
        return _sharedInstance;
    } else {
        if (self = [super init]) {
            context = [IGRepositoryLocator sharedInstance];
        }
        return self;
    }
    
}

- (BOOL) isAuthenticated {
    if (self.currentAuthenticationResponse.pendingActionRequest == nil && self.currentAuthenticationResponse.token != nil &&
        self.currentAuthenticationResponse.authenticationStatus == 1) {
        return YES;
    }
    else{
        return NO;
    }
};

- (NSDictionary *) settings {
    if (!_settings) {
        //        _settings = [context.settingsRepository getSettings];
    }
    
    return _settings;
}

-(id)getSettingFor:(NSString*)settingKey
{
    return [self.settings objectForKey:settingKey];
}

-(void)autoLogin:(void (^)(NSError *error))block {
    
    //__weak typeof(self) weakSelf = self;
    
    [context.securityRepository autoLogin:^(IGAuthenticationResponse *response, NSError *error) {
        if (!error){
            //weakSelf.adviser = adviser;
        }
        
        block(error);
    }];
    
}

-(void)login:(IGAuthenticationRequest *)request
   withBlock:(void (^)(NSError *error))block {
    
    __weak typeof(self) weakSelf = self;
    
    [context.securityRepository login:request withBlock:^(IGAuthenticationResponse *response, NSError *error) {
        if (!error){
            weakSelf.currentAuthenticationRequest = request;
            weakSelf.currentAuthenticationResponse = response;
        }
        
        block(error);
    }];
}

-(void)GetOficinas:(IGAuthenticationRequest *)request
   withBlock:(void (^)(NSError *error))block {
    
    __weak typeof(self) weakSelf = self;
    
    [context.securityRepository login:request withBlock:^(IGAuthenticationResponse *response, NSError *error) {
        if (!error){
            weakSelf.currentAuthenticationRequest = request;
            weakSelf.currentAuthenticationResponse = response;
        }
        
        block(error);
    }];
}

-(void)loginForRestorePass:(IGForgotPasswordRequest *)request
   withBlock:(void (^)(NSError *error))block {
    
    __weak typeof(self) weakSelf = self;
    
    [context.securityRepository loginForRestorePass:request withBlock:^(IGForgotPasswordResponse *response, NSError *error) {
        if (!error){
            weakSelf.forgotPasswordRequest = request;
            weakSelf.forgotPasswordResponse = response;
        }
        
        block(error);
    }];
}

-(void)getCompanies:(NSString *)docNumber withDocType:(NSString *)docType withBlock:(void (^)(NSError *))block
{
    __weak typeof(self) weakSelf = self;
    
   [context.balancesRepository getCompanies:docNumber withDocType:docType withBlock:^(NSArray *response, NSError *error) {
       if (!error) {
           weakSelf.currentCompanies = response;
       }
       
       block(error);
   }];
}

-(void)getStatements:(IGStatementsRequest *)request withBlock:(void (^)(NSError *))block
{
    __weak typeof(self) weakSelf = self;
    
    [context.statementsRepository getStatements:request withBlock:^(NSArray *response, NSError *error) {
    
        if (!error) {
            weakSelf.currentStatements = response;
        }
        
        block(error);
    }];

}

-(void)getAgents:(NSString *)docNumber withDocType:(NSString *)docType withBlock:(void (^)(NSError *))block
{
    __weak typeof(self) weakSelf = self;
    
    [context.agentsRepository getAgents:docNumber withDocType:docType withBlock:^(NSArray *response, NSError *error) {
        if (!error) {
            weakSelf.currentAgents = response;
        }
        
        block(error);
    }];
}

- (NSMutableArray *) currentTransactionsHistory {
    
    if (!_currentTransactionsHistory) {
        _currentTransactionsHistory = [[NSMutableArray alloc] initWithCapacity:(PAGE_RESULTS_SIZE * 2)];
    }
    return _currentTransactionsHistory;
}

-(void)searchTransactionsHistoryNextPage:(NSString *)product withContract:(NSString *)contract withPlan:(NSString *)plan docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(NSError *error))block {
    
    if ((self.currentTransactionsHistory.count % PAGE_RESULTS_SIZE) == 0) {
        
        currentPage++;
        
        [self getTransactionsHistory:product withContract:contract withPlan:plan withSet:currentPage docNumber:docNumber docType:docType withBlock:^(NSError *error) {
            if (error &&  currentPage > FIRST_PAGE_INDEX) {
                currentPage--;
            }
            block(error);
        }];
    } else {
        block([IGError defaultEndOfSearchError]);
    }
}
/*roberm
-(void)searchTransactionsHistoryPullToRefresh:(NSString *)product withContract:(NSString *)contract withPlan:(NSString *)plan docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(NSError *error))block {
    
    currentPage = FIRST_PAGE_INDEX;
    [self.currentTransactionsHistory removeAllObjects];
    self.currentTransactionsHistory = nil;
    [self getTransactionsHistory:product withContract:contract withPlan:plan withSet:currentPage docNumber:docNumber docType:docType withBlock:block];
}
*/
-(void)getTransactionsHistory:(NSString *)product withContract:(NSString *)contract withPlan:(NSString *)plan withSet:(NSInteger)set docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(NSError *))block
{
    __weak typeof(self) weakSelf = self;
    
    [context.transactionsHistoryRepository getTransactionsHistory:product withContract:contract withPlan:plan withSet:set docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:^(NSArray *response, NSError *error) {
        if (!error) {
            [weakSelf.currentTransactionsHistory addObjectsFromArray:response];
        }
        
        block(error);
    }];
}

-(void)getTransactionsHistoryDetail:(NSString *)product withContract:(NSString *)contract withEvent:(NSString *)event withTransaction:(NSString *)transaction docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(NSError *))block
{
    __weak typeof(self) weakSelf = self;
    
    [context.transactionsHistoryDetailRepository getTransactionsHistoryDetail:product withContract:contract withEvent:event withTransaction:transaction docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:^(IGTransactionDetailResponse *response, NSError *error) {
        if (!error) {
            weakSelf.currentTransactionsHistoryDetail = response;
        }
        
        block(error);
    }];
}

-(void)getContractDetail:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withChannel:(NSInteger)channel withBlock:(void (^)(NSError *))block
{
    __weak typeof(self) weakSelf = self;
    
    [context.contractDetailRepository getContractDetail:docNumber withDocType:docType withProduct:product withPlan:plan withContract:contract withChannel:(NSInteger)channel withBlock:^(IGContractDetail *response, NSError *error) {
        if (!error) {
            weakSelf.currentContractDetail = response;
        }
        
        block(error);
    }];
}

-(void)getGenerateList:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withBlock:(void (^)(NSError *))block
{
    __weak typeof(self) weakSelf = self;
    
    [context.generateListRepository getGenerateList:docNumber withDocType:docType withProduct:product withPlan:plan withContract:contract withBlock:^(NSArray *response, NSError *error) {
        if (!error) {
            weakSelf.currentCertificates = response;
        }
        
        block(error);
    }];
}

-(void)getDownloadDocument:(NSString *)url withPeriod:(NSString *)period withDocType:(NSString *)docType withDocNumber:(NSString *)docNumber withReportType:(NSString *)reportType andFilePath:(NSString *)filePath withBlock:(void (^)(id response, NSError *error))block progress:(void (^)(float progress)) progressBlock{
    
    
    [context.downloadRepository getDownloadDocument:url withPeriod:period withDocType:docType withDocNumber:docNumber withReportType:reportType andFilePath:filePath withBlock:^(id response, NSError *error) {
        
        block(response, error);
    }  progress:^(float progress) {
        progressBlock(progress);
    }];
}

-(void)postDownloadDocument:(NSString *)url withDocNumber:(NSString *)docNumber withDocType:(NSString *)docType withType:(NSString *)type withProductCode:(NSString *)productCode withContract:(NSString *)contract withPlanCode:(NSString *)planCode withEventNumber:(NSString *)eventNumber withTransactionNumber:(NSString *)transactionNumber withEffectiveDate:(NSString *)effectiveDate withNetValue:(NSString *)netValue withDescription:(NSString *)description andFilePath:(NSString *)filePath withBlock:(void (^)(id, NSError *))block progress:(void (^)(float progress)) progressBlock{
    
    [context.downloadRepository postDownloadDocument:url withDocNumber:docNumber withDocType:docType withType:type withProductCode:productCode withContract:contract withPlanCode:planCode withEventNumber:eventNumber withTransactionNumber:transactionNumber withEffectiveDate:effectiveDate withNetValue:netValue withDescription:description andFilePath:filePath withBlock:^(id response, NSError *error) {
        
        block(response, error);
    } progress:^(float progress) {
           progressBlock(progress);
    }];

}

-(void)postDownloadDocumentCertificate:(IGReportRequest *)request
                             andFilePath:(NSString *)filePath
                             withBlock:(void (^)(id response, NSError *error))block progress:(void (^)(float progress)) progressBlock{
    
    [context.downloadRepository postDownloadDocumentCertificate:request andFilePath:filePath withBlock:^(id response, NSError *error) {
        
        block(response, error);
    }progress:^(float progress) {
          progressBlock(progress);
    }];
    
}


-(void)logout{
    self.currentAuthenticationResponse = nil;
    self.currentAuthenticationRequest = nil;
    self.forgotPasswordRequest = nil;
    self.currentAnswer=nil;
    self.selectedQuestions = nil;
    self.selectedDocumentType = nil;
    self.currentCompanies = nil;
    self.currentSelectedCompany = nil;
    self.currentSelectedProduct = nil;
    self.currentSelectedContract = nil;
    self.keysForProducts = nil;
    self.valuesForProducts = nil;
    self.currentStatements = nil;
    self.currentSelectedStatement = nil;
    self.currentAgents = nil;
    self.currentSelectedAgent = nil;
    [self.currentTransactionsHistory removeAllObjects];
    self.currentTransactionsHistory = nil;
    self.currentSelectedTransactionsHistory = nil;
    self.currentTransactionsHistoryDetail = nil;
    self.currentSelectedDocumentHistoryDetail = nil;
    self.currentContractDetail = nil;
    self.currentCertificates = nil;
    self.currentSelectedCertificate = nil;
    self.currentReportRequest = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.appCurrentDateTime forKey:@"ApplicationLastDateTime"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[IGAPIClient sharedInstance] clearAuthorizationHeader];
    [context.securityRepository logout];
}

-(void)resetDataSource
{
    currentPage = FIRST_PAGE_INDEX;
    [self.currentTransactionsHistory removeAllObjects];
    self.currentTransactionsHistory = nil;
}

@end
