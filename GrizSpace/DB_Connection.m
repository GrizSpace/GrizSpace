//
//  DB_Connection.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DB_Connection.h"
#import "CBAnnotationInfo.h"


@implementation DB_Connection



//updates the name and path for the database.
-(void)updateNames{
    databaseName = @"WheresMyClass.sqlite";
    NSArray* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDir = [documentsPath objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
}

//checks if db  was found and if not copies it from the resources dir.
-(void)checkAndCreateDatabase{
    BOOL success;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success)
    {
        return;
    }
    NSString* databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}


-(void) saveDatabase{
}


//gets the building data from the database, populates it and returns it.
-(NSMutableArray*) GetBuildingsData
{
    NSMutableArray* tmpArray = [[NSMutableArray alloc] init];
    db = [FMDatabase databaseWithPath:databasePath];
    [db setLogsErrors:true];
    [db setTraceExecution:true];
    if(![db open])
    {
        NSLog(@"Failed to open database");
        return nil;
    }
    else
    {
        NSLog(@"Openned GrizSpace database successfully");
    }
    
    
    /**********************************************
     Set the query to get the building from the db.
    **********************************************/    
    FMResultSet* rs = [db executeQuery: @"SELECT BLDG, ROOM, DAYS, TIME, DATES, SUBJ, CRSE, CRN, Name, idGPS, Latitude, Longitude, Radius FROM MainCampusSpring2012 as mcs inner join Building as b on mcs.BLDG = b.idBuilding inner join GPS on b.fk_idGPS = GPS.idGPS order by idBuilding"];
    while([rs next])
    {   
        
        CBAnnotationInfo* tmpAnnotationInfo = [[CBAnnotationInfo alloc] initWithAnnotationInfo:[rs stringForColumn:@"idBuilding"] idGPS:[rs intForColumn:@"idGPS"] Name:[rs stringForColumn:@"Name"] latitude:[rs doubleForColumn:@"Latitude"] longitude:[rs doubleForColumn:@"Longitude"] radius:[rs doubleForColumn:@"Radius"]];
        [tmpArray addObject:tmpAnnotationInfo];
        NSLog(@"Get DB item: %@", [rs stringForColumn:@"Name"]);
    }
    [db close];
    

    return tmpArray;
}
@end
