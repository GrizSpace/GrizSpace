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
    
    const char *sql = "SELECT idBuilding, Name, Latitude, Longitude, Radius FROM building inner join GPS on building.fk_idGPS = GPS.idGPS order by Name;";
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code 
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
	
    NSInteger itemCounter = 0;
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
            
            double latitude = [[NSString stringWithUTF8String: (char *)sqlite3_column_text(statement, 2)] doubleValue];
            double longitude = [[NSString stringWithUTF8String: (char *)sqlite3_column_text(statement, 3)]  doubleValue];            
            NSInteger radius = (NSInteger)sqlite3_column_text(statement, 4);            
            
            
            //  Set all the attributes of the building
            building.buildingIndex = itemCounter;
            building.idBuilding = (idBuilding) ? [NSString stringWithUTF8String:idBuilding] : @"";
            building.name = (name) ? [NSString 
                                      stringWithUTF8String:name] : @"";
            building.Longitude = longitude;
            building.Latitude = latitude;
            building.Radius = radius;            
            [buildings addObject:building];
            
            itemCounter++;
            
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
    
    const char *sql = "SELECT abbr FROM Subject;";
    
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
            char *abbr = (char *)sqlite3_column_text(statement, 0);  // changed column to zero since current select statement is only querying for abbr
          
            //  Set all the attributes of the subject
            
            subject.abbr = (abbr) ? [NSString stringWithUTF8String:abbr] : @"";
            
            NSLog(@"%@", subject.abbr);
                        
            
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

//-----------------------------------------------------
//              getAllInterests
//-----------------------------------------------------
- (NSMutableArray*) getAllInterests
{
    //  The array of subjects that we will create
    NSMutableArray *interests = [[NSMutableArray alloc] init];
    
    //  The SQL statement that we plan on executing against the database
    
    const char *sql = "SELECT InterestName FROM BoredInterest;";
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code 
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
	
    if ( sqlResult== SQLITE_OK) {
        // Step through the results - once for each row.
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //  allocate a Product object to add to products array
            
            InterestsModel  *interest = [[InterestsModel alloc] init];
            
            // The second parameter is the column index (0 based) in 
            // the result set.
            char *InterestName = (char *)sqlite3_column_text(statement, 0);
            
            //  Set all the attributes of the building
            
            interest.InterestName = (InterestName) ? [NSString stringWithUTF8String:InterestName] : @"";
            
            
            [interests addObject:interest];
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }   
    
    return interests;
    
}
//-----------------------------------------------------
//              getAllCoursesGivenSubject
//-----------------------------------------------------

//declare method and pass in Subject.id

- (NSMutableArray*) getAllCoursesGivenSubject:(NSInteger) Subject_id
{
    //  The array of CoursesGivenSubject that we will create
    NSMutableArray *coursesGivenSubject = [[NSMutableArray alloc] init];
    
    //  The SQL statement that we plan on executing against the database
    
  //  NSString *sql = @"SELECT course.id, course.number FROM Course INNER JOIN Subject WHERE course.id = %@", Subject_id;
    
   
    
    NSString *sql = [NSString stringWithFormat:@"SELECT course.id, course.number FROM Course INNER JOIN Subject WHERE course.id = %@", Subject_id];
    
    
    const char *sqlstatement = [sql UTF8String];
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code 
    int sqlResult = sqlite3_prepare_v2(database, sqlstatement, -1, &statement, NULL);
	
    if ( sqlResult== SQLITE_OK) {
        // Step through the results - once for each row.
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //  allocate a CourseModel object to add to buildings array
            
            CourseModel  *course = [[CourseModel alloc] init];
            
            // The second parameter is the column index (0 based) in 
            // the result set.
            
            //char *id = (char *)sqlite3_column_text(statement, 0);
            char *number = (char *)sqlite3_column_text(statement, 1);
            
            
            //  Set all the attributes of the course
            course.id = (NSInteger)sqlite3_column_text(statement, 0);  
            //course.id= id;
            //below doesn't work.  fix it?  not sure how tonight 3/21
            //course.id = (id) ? [NSInteger stringWithUTF8String:id] : @"";
            course.number = (number) ? [NSString 
                                      stringWithUTF8String:number] : @"";         
            
            [coursesGivenSubject addObject:course];
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }   
    
    return coursesGivenSubject;
    
}

// adding getAllCourses so I can get at some CourseModel objects for testing
//-----------------------------
//  getAllCourses
//----------------------------
-(NSMutableArray*) getAllCourses
{
    NSMutableArray *courses = [[NSMutableArray alloc] init];
    
   
    const char *sql = "SELECT Course.id, number, subject_id, abbr FROM Course inner join Subject on Course.subject_id = Subject.id;";
   
    sqlite3_stmt *statement;
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    
    if (sqlResult == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            CourseModel *course = [[CourseModel alloc] init];
            
          //  char *id = (char *)sqlite3_column_text(statement, 0);
            char *number = (char *)sqlite3_column_text(statement, 1);
            
            char *abbr = (char *)sqlite3_column_text(statement, 3);
            
            course.number = (number) ? [NSString stringWithUTF8String:number] : @"";
             course.subject = (abbr) ? [NSString stringWithUTF8String:abbr] : @"";
            NSLog(@"Adding course subject: %@", course.subject);
            [courses addObject:course];
            
        }
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with DB: ");
        NSLog(@"%d", sqlResult);
    }
    return courses;
}





@end
