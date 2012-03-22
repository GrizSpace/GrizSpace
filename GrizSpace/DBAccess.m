//
//  DBAccess.m
//  DBConnectionPractice
//
//  Created by Jaylene Naylor on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBAccess.h"
#import "GPSModel.h"
@implementation DBAccess

//Reference to the SQLite database

sqlite3* database;



-(id) init
{
    //  Call super init to invoke superclass initiation code
    if ((self = [super init]))
    {
        //  set the reference to the database
        [self initializeDatabase];
    }
    return self;
}


// Open the database connection
- (void)initializeDatabase {
    
    // Get the database from the application bundle. 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GrizSpaceDB" 
                                                     ofType:@"sqlite"];
    
    // Open the database. 
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
    {
        NSLog(@"Opening Database");
    } 
    else 
    {
        // Call close to properly clean up 
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database: '%s'.", 
                  sqlite3_errmsg(database));
    }
}

-(void) closeDatabase
{
    // Close the database.
    if (sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Error: failed to close database: '%s'.", 
                  sqlite3_errmsg(database));
    }
}

//-----------------------------------------------------
//              getAllBuildings
//-----------------------------------------------------
- (NSMutableArray*) getAllBuildings
{
    //  The array of buildings that we will create
    NSMutableArray *buildings = [[NSMutableArray alloc] init];
    
    //  The SQL statement that we plan on executing against the database
    
    const char *sql = "SELECT idBuilding, Name, Latitude, Longitude, Radius FROM building inner join GPS on building.fk_idGPS = GPS.idGPS order by idBuilding;";
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code 
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
	
    if ( sqlResult== SQLITE_OK) {
        // Step through the results - once for each row.
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //  allocate a BuildingModel object to add to buildings array
            
            BuildingModel  *building = [[BuildingModel alloc] init];
            
            // The second parameter is the column index (0 based) in 
            // the result set.
            char *idBuilding = (char *)sqlite3_column_text(statement, 0);
            char *name = (char *)sqlite3_column_text(statement, 1);
            //char *fk_idGPS = (char *)sqlite3_column_text(statement, 2);
            
            double longitude = [[NSString stringWithUTF8String: (char *)sqlite3_column_text(statement, 2)] doubleValue];
            double latitude = [[NSString stringWithUTF8String: (char *)sqlite3_column_text(statement, 3)]  doubleValue];            
            NSInteger radius = (NSInteger)sqlite3_column_text(statement, 4);            
            
            
            //  Set all the attributes of the building
            building.idBuilding = (idBuilding) ? [NSString stringWithUTF8String:idBuilding] : @"";
            building.name = (name) ? [NSString 
                                      stringWithUTF8String:name] : @"";
            building.Longitude = longitude;
            building.Latitude = latitude;
            building.Radius = radius;            
            [buildings addObject:building];
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }   
    
    return buildings;
    
}

//-----------------------------------------------------
//              getAllSubjects
//-----------------------------------------------------
- (NSMutableArray*) getAllSubjects
{
    //  The array of subjects that we will create
    NSMutableArray *subjects = [[NSMutableArray alloc] init];
    
    //  The SQL statement that we plan on executing against the database
    
    const char *sql = "SELECT * FROM Subject;";
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code 
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
	
    if ( sqlResult== SQLITE_OK) {
        // Step through the results - once for each row.
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //  allocate a Product object to add to products array
            
            SubjectModel  *subject = [[SubjectModel alloc] init];
            
            // The second parameter is the column index (0 based) in 
            // the result set.
            char *idSubject = (char *)sqlite3_column_text(statement, 0);
          
            //  Set all the attributes of the building
            
            subject.idSubject = (idSubject) ? [NSString stringWithUTF8String:idSubject] : @"";
                        
            
            [subjects addObject:subject];
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }   
    
    return subjects;
    
}
 





@end
