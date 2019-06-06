//
//  IGSalesforceApp.h
//  salesforce
//
//  Created by Armando Restrepo on 11/25/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "IGBaseModel.h"
#import "IGAuthenticationRequest.h"
#import "IGAuthenticationResponse.h"
#import "IGForgotPasswordRequest.h"
#import "IGStatementsRequest.h"
#import "IGForgotPasswordResponse.h"
#import "IGAnswer.h"
#import "IGCompany.h"
#import "IGProduct.h"
#import "IGContract.h"
#import "IGAgent.h"
#import "OMPeriod.h"
#import "IGTransaction.h"
#import "IGTransactionDetailResponse.h"
#import "IGDocument.h"
#import "IGContractDetail.h"
#import "IGContractDetailGroups.h"
#import "IGGenerateList.h"
#import "IGReportRequest.h"

@interface IGMobileApp : IGBaseModel

+ (IGMobileApp *) sharedInstance;

@property (nonatomic, getter = isAuthenticated) BOOL authenticated;

//User
@property (nonatomic, strong) IGAuthenticationResponse *currentAuthenticationResponse;
@property (nonatomic, strong) IGAnswer *currentAnswer;
@property (nonatomic, strong) IGAuthenticationRequest *currentAuthenticationRequest;
@property (nonatomic, strong) IGForgotPasswordRequest *forgotPasswordRequest;
@property (nonatomic, strong) IGForgotPasswordResponse *forgotPasswordResponse;
@property (nonatomic, strong) NSMutableArray *selectedQuestions;
@property (nonatomic, strong) NSString *selectedDocumentType;
@property (nonatomic, strong) NSString *currentNewPassword;
@property (nonatomic, strong) NSString *currentUrl;
@property (nonatomic, strong) NSString *currentTitle;
@property (nonatomic, strong) NSArray *currentCompanies;
@property (nonatomic, strong) NSArray *currentStatements;
@property (nonatomic, strong) NSArray *currentAgents;
@property (nonatomic, strong) NSMutableArray *currentTransactionsHistory;
@property (nonatomic, strong) NSArray *currentCertificates;
@property (nonatomic, strong) IGCompany * currentSelectedCompany;
@property (nonatomic, strong) IGProduct * currentSelectedProduct;
@property (nonatomic, strong) IGContract * currentSelectedContract;
@property (nonatomic, strong) IGAgent * currentSelectedAgent;
@property (nonatomic, strong) OMPeriod * currentSelectedStatement;
@property (nonatomic, strong) IGTransaction * currentSelectedTransactionsHistory;
@property (nonatomic, strong) IGTransactionDetailResponse * currentTransactionsHistoryDetail;
@property (nonatomic, strong) IGDocument * currentSelectedDocumentHistoryDetail;
@property (nonatomic, strong) IGContractDetail * currentContractDetail;
@property (nonatomic, strong) IGContractDetailGroups * currentSelectedGroupsField;
@property (nonatomic, strong) IGGenerateList * currentSelectedCertificate;
@property (nonatomic, strong) IGReportRequest *currentReportRequest;
@property (nonatomic, strong) NSMutableArray * keysForProducts;
@property (nonatomic, strong) NSMutableArray * valuesForProducts;
@property (nonatomic, strong) NSString *currentReportType;
@property (nonatomic, strong) NSString *currentDownloadDocumentType;
@property (nonatomic, strong) OMUser * currentUser;


@property (nonatomic, strong) NSString* appUniqueIdentifier;
@property (nonatomic, strong) NSString* appCurrentIPAddress;
@property (nonatomic, strong) NSString* appCurrentDateTime;

-(id)getSettingFor:(NSString*)settingKey;

-(void)autoLogin:(void (^)(NSError *error))block;

-(void)login:(IGAuthenticationRequest *)request
   withBlock:(void (^)(NSError *error))block;

-(void)loginForRestorePass:(IGForgotPasswordRequest *)request
                 withBlock:(void (^)(NSError *error))block;

-(void) getCompanies:(NSString *)docNumber
         withDocType:(NSString *)docType
           withBlock:(void (^)(NSError *error))block;

-(void) getStatements:(IGStatementsRequest *)request
            withBlock:(void (^)(NSError *error))block;

-(void) getAgents:(NSString *)docNumber
      withDocType:(NSString *)docType
        withBlock:(void (^)(NSError *error))block;

-(void)searchTransactionsHistoryNextPage:(NSString *)product
                            withContract:(NSString *)contract
                                withPlan:(NSString *)plan
                               docNumber:(NSString*)docNumber
                                 docType:(NSString*)docType
                               withBlock:(void (^)(NSError *error))block;
/*roberm
-(void)searchTransactionsHistoryPullToRefresh:(NSString *)product
                                 withContract:(NSString *)contract
                                     withPlan:(NSString *)plan
                                    docNumber:(NSString*)docNumber
                                      docType:(NSString*)docType
                                    withBlock:(void (^)(NSError *error))block;
*/
-(void)getTransactionsHistory:(NSString *)product
                 withContract:(NSString *)contract
                     withPlan:(NSString *)plan
                      withSet:(NSInteger)set
                    docNumber:(NSString*)docNumber
                      docType:(NSString*)docType
                    withBlock:(void (^)(NSError *))block;

-(void)getTransactionsHistoryDetail:(NSString *)product
                       withContract:(NSString *)contract
                          withEvent:(NSString *)event
                    withTransaction:(NSString *)transaction
                          docNumber:(NSString*)docNumber
                            docType:(NSString*)docType
                          withBlock:(void (^)(NSError *))block;

-(void)getContractDetail:(NSString *)docNumber
             withDocType:(NSString *)docType
             withProduct:(NSString *)product
                withPlan:(NSString *)plan
            withContract:(NSString *)contract
            withChannel:(NSInteger)channel
               withBlock:(void (^)(NSError *))block;

-(void)getGenerateList:(NSString *)docNumber
             withDocType:(NSString *)docType
             withProduct:(NSString *)product
                withPlan:(NSString *)plan
            withContract:(NSString *)contract
               withBlock:(void (^)(NSError *))block;

-(void)getDownloadDocument:(NSString *)url
                withPeriod:(NSString *)period
               withDocType:(NSString *)docType
             withDocNumber:(NSString *)docNumber
            withReportType:(NSString *)reportType
               andFilePath:(NSString *)filePath
                 withBlock:(void (^)(id response, NSError *error))block
                  progress:(void (^)(float progress)) progressBlock;

-(void)postDownloadDocument:(NSString *)url
              withDocNumber:(NSString *)docNumber
                withDocType:(NSString *)docType
                   withType:(NSString *)type
            withProductCode:(NSString *)productCode
               withContract:(NSString *)contract
               withPlanCode:(NSString *)planCode
            withEventNumber:(NSString *)eventNumber
      withTransactionNumber:(NSString *)transactionNumber
          withEffectiveDate:(NSString *)effectiveDate
               withNetValue:(NSString *)netValue
            withDescription:(NSString *)description
                andFilePath:(NSString *)filePath
                  withBlock:(void (^)(id, NSError *))block
                   progress:(void (^)(float progress)) progressBlock;

-(void)postDownloadDocumentCertificate:(IGReportRequest *)request
                           andFilePath:(NSString *)filePath
                             withBlock:(void (^)(id response, NSError *error))block
                              progress:(void (^)(float progress)) progressBlock;

-(void)logout;

-(void)resetDataSource;

@end
