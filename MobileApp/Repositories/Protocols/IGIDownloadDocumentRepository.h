//
//  IGIDownloadDocumentRepository.h
//  MobileApp
//
//  Created by Rober on 23/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGReportRequest.h"

@protocol IGIDownloadDocumentRepository<NSObject>

@required

- (void) getDownloadDocument:(NSString *)url
                  withPeriod:(NSString *)period
                 withDocType:(NSString *)docType
               withDocNumber:(NSString *)docNumber
              withReportType:(NSString *)reportType
                 andFilePath:(NSString *)filePath
                   withBlock:(void (^)(id response, NSError *error))block
                    progress:(void (^)(float progress)) progressBlock;

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
                    progress:(void (^)(float progress)) progressBlock;

-(void)postDownloadDocumentCertificate:(IGReportRequest *)request
                           andFilePath:(NSString *)filePath
                             withBlock:(void (^)(id response, NSError *error))block
                              progress:(void (^)(float progress)) progressBlock;

@end