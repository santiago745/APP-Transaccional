//
//  IGRepositoryLocator.m
//  salesforce
//
//  Created by Armando Restrepo on 11/20/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGRepositoryLocator.h"
#import "IGTestSecurityRepository.h"
#import "IGSecurityRepository.h"
#import "IGISettingsRepository.h"
#import "IGTestSettingsRepository.h"
#import "IGSettingsRepository.h"
#import "IGTestBalancesRepository.h"
#import "IGBalancesRepository.h"
#import "IGTestStatementsRepository.h"
#import "IGTestAgentsRepository.h"
#import "IGAgentsRepository.h"
#import "IGTransactionsHistoryRepository.h"
#import "IGTestTransactionsHistoryRepository.h"
#import "IGTransactionsHistoryDetailRepository.h"
#import "IGTestTransactionsHistoryDetailRepository.h"
#import "IGContractDetailRepository.h"
#import "IGTestContractDetailRepository.h"
#import "IGGenerateListRepository.h"
#import "IGTestGenerateListRepository.h"
#import "IGDownloadDocumentRepository.h"

@implementation IGRepositoryLocator

bool configuration;

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id) init {
    if (_sharedInstance){
        return _sharedInstance;
    }
    else{
        if (self = [super init]){
            //init properties
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            configuration = [[[bundle infoDictionary] objectForKey:@"Use test repos"] boolValue];
        }
        return self;
    }
}

- (id<IGISecurityRepository>) securityRepository {
    if (USE_TEST_REPOS){
        return [IGTestSecurityRepository sharedInstance];
    }
    else{
        return [IGSecurityRepository sharedInstance];
    }
}

- (id<IGISettingsRepository>) settingsRepository {
    if (configuration){
        return [IGTestSettingsRepository sharedInstance];
    }
    else{
        return [IGSettingsRepository sharedInstance];
    }
}

- (id<IGIBalancesRepository>) balancesRepository {
    if (USE_TEST_REPOS){
        return [IGTestBalancesRepository sharedInstance];
    }
    else{
        return [IGBalancesRepository sharedInstance];
    }
}

- (id<IGIStatementsRepository>) statementsRepository {
    if (USE_TEST_REPOS){
        return [IGTestStatementsRepository sharedInstance];
    }
    else{
        return [IGStatementsRepository sharedInstance];
    }
}

- (id<IGIAgentsRepository>) agentsRepository {
    if (USE_TEST_REPOS){
        return [IGTestAgentsRepository sharedInstance];
    }
    else{
        return [IGAgentsRepository sharedInstance];
    }
}

- (id<IGITransactionsHistoryRepository>) transactionsHistoryRepository {
    if (USE_TEST_REPOS){
        return [IGTestTransactionsHistoryRepository sharedInstance];
    }
    else{
        return [IGTransactionsHistoryRepository sharedInstance];
    }
}

- (id<IGITransactionsHistoryDetailRepository>) transactionsHistoryDetailRepository {
    if (USE_TEST_REPOS){
        return [IGTestTransactionsHistoryDetailRepository sharedInstance];
    }
    else{
        return [IGTransactionsHistoryDetailRepository sharedInstance];
    }
}

- (id<IGIContractDetailRepository>) contractDetailRepository {
    if (USE_TEST_REPOS){
        return [IGTestContractDetailRepository sharedInstance];
    }
    else{
        return [IGContractDetailRepository sharedInstance];
    }
}

- (id<IGIGenerateListRepository>) generateListRepository {
    if (USE_TEST_REPOS){
        return [IGTestGenerateListRepository sharedInstance];
    }
    else{
        return [IGGenerateListRepository sharedInstance];
    }
}

- (id<IGIDownloadDocumentRepository>) downloadRepository {
    return [IGDownloadDocumentRepository sharedInstance];
}

@end
