//
//  IGRepositoryLocator.h
//  salesforce
//
//  Created by Armando Restrepo on 11/20/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGISecurityRepository.h"
#import "IGISettingsRepository.h"
#import "IGIBalancesRepository.h"
#import "IGStatementsRepository.h"
#import "IGAgentsRepository.h"
#import "IGTransactionsHistoryRepository.h"
#import "IGTransactionsHistoryDetailRepository.h"
#import "IGContractDetailRepository.h"
#import "IGGenerateListRepository.h"
#import "IGDownloadDocumentRepository.h"

@interface IGRepositoryLocator : NSObject

+ (id) sharedInstance;

@property (nonatomic, strong, readonly) id<IGISecurityRepository> securityRepository;
@property (nonatomic, strong, readonly) id<IGISettingsRepository> settingsRepository;
@property (nonatomic, strong, readonly) id<IGIBalancesRepository> balancesRepository;
@property (nonatomic, strong, readonly) id<IGIStatementsRepository> statementsRepository;
@property (nonatomic, strong, readonly) id<IGIAgentsRepository> agentsRepository;
@property (nonatomic, strong, readonly) id<IGITransactionsHistoryRepository> transactionsHistoryRepository;
@property (nonatomic, strong, readonly) id<IGITransactionsHistoryDetailRepository> transactionsHistoryDetailRepository;
@property (nonatomic, strong, readonly) id<IGIContractDetailRepository> contractDetailRepository;
@property (nonatomic, strong, readonly) id<IGIGenerateListRepository> generateListRepository;
@property (nonatomic, strong, readonly) id<IGIDownloadDocumentRepository> downloadRepository;

@end
