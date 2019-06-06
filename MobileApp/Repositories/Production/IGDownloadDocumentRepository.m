//
//  IGDownloadDocument.m
//  MobileApp
//
//  Created by Rober on 23/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGDownloadDocumentRepository.h"
#import "IGError.h"
#import "IGAPIClient.h"
#import "MTLJSONAdapter.h"
#import "IGCompany.h"
#import "IGMobileApp.h"

@implementation IGDownloadDocumentRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void) getDownloadDocument:(NSString *)url
                 withPeriod:(NSString *)period
                withDocType:(NSString *)docType
              withDocNumber:(NSString *)docNumber
             withReportType:(NSString *)reportType
                andFilePath:(NSString *)filePath
                  withBlock:(void (^)(id response, NSError *error))block
                   progress:(void (^)(float progress)) progressBlock{
    
    NSString *token = [NSString stringWithFormat:@"Basic %@",[[IGMobileApp sharedInstance] currentAuthenticationResponse].token];
    NSString *currentURL = [NSString stringWithFormat:@"%@Statements?period=%@&DocType=%@&DocNumber=%@&ReportType=%@", url, period, docType, docNumber, reportType];
    
    NSURL *URL = [NSURL URLWithString:currentURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest addValue:token forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:mutableRequest];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progressBlock( (float)totalBytesRead / totalBytesExpectedToRead);
     
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
    
    [operation start];
}

-(void) postDownloadDocument:(NSString *)url
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
                   withBlock:(void (^)(id response, NSError *error))block
                    progress:(void (^)(float progress)) progressBlock{
    
    NSString *token = [NSString stringWithFormat:@"Basic %@",[[IGMobileApp sharedInstance] currentAuthenticationResponse].token];
    NSString *currentURL = [NSString stringWithFormat:@"%@Transactions?docNumber=%@&docType=%@&type=%@", url, docNumber, docType, type];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:currentURL]];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/pdf", nil];
    
    
    NSDictionary *parameters =  @{ @"ProductCode": productCode,
                                   @"Contract": contract,
                                   @"PlanCode": planCode,
                                   @"EventNumber": eventNumber,
                                   @"TransactionNumber": transactionNumber,
                                   @"EffectiveDate": effectiveDate,
                                   @"NetValue": netValue,
                                   @"Description": description,
                                   };
    
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /*AFHTTPRequestOperation *requestOperation = */
    AFHTTPRequestOperation *op = [manager POST:currentURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        operation.responseSerializer = [AFHTTPResponseSerializer serializer];
         block(responseObject, nil);
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (block) {
                block(responseObject, nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (block) {
                NSLog(@"Error -> %@", operation.responseString);
                block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
            }
        }];
        
        [operation start];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progressBlock( (float)totalBytesRead / totalBytesExpectedToRead);

    }];
    
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
}

-(void)postDownloadDocumentCertificate:(IGReportRequest *)request
                           andFilePath:(NSString *)filePath
                             withBlock:(void (^)(id response, NSError *error))block
                              progress:(void (^)(float progress)) progressBlock{
    
    
    
    NSString *token = [NSString stringWithFormat:@"Basic %@",[[IGMobileApp sharedInstance] currentAuthenticationResponse].token];
   NSString *currentURL = [NSString stringWithFormat:@"%@statements", [IGAPIClient sharedInstance].baseURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager] ;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/pdf", nil];
    
    
    NSArray *fields = [MTLJSONAdapter JSONArrayFromModels:request.fields];
    NSDictionary *parameters =  @{ @"Contract": request.contract,
                                   @"DocNumber": request.docNumber,
                                   @"DocType": request.docType,
                                   @"Fields": fields,
                                   @"Plan": request.plan,
                                   @"Product": request.product,
                                   @"ReportCode": request.reportCode,
                                   @"ReportType":  [NSNumber numberWithInt:request.reportType],
                                   };
    
   
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation *op = [manager POST:currentURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        operation.responseSerializer = [AFHTTPResponseSerializer serializer];
        block(responseObject, nil);
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (block) {
                block(responseObject, nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (block) {
                NSLog(@"Error -> %@", operation.responseString);
                block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
            }
        }];
        
        [operation start];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progressBlock( (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
}

@end
