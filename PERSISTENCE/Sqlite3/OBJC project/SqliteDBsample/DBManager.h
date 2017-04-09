//
//  DBManager.h
//  SqliteDBsample
//
//  Created by Luis Castillo on 8/12/16.
//  Copyright © 2016 LC. All rights reserved.
//
#import <sqlite3.h>
#import <Foundation/Foundation.h>

@interface DBManager : NSObject

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;


-(instancetype)initWithDatabaseFilename:(NSString * )dbFileName;
-(void)copyDatabaseIntoDocumentsDirectory;

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;




@end
