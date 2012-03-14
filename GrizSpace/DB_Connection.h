//
//  DB_Connection.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//This file is used to interact with the database as needed to get or save data.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DB_Connection : NSObject
{
    NSString* databaseName;
    NSString* databasePath;
    NSString* queryString;
    FMDatabase* db;
}

-(NSMutableArray*) GetBuildingsData;



@end
