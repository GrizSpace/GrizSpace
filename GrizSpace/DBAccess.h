//
//  DBAccess.h
//  DBConnectionPractice
//
//  Created by Jaylene Naylor on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

//p.38
#import "BuildingModel.h"
#import "SubjectModel.h"
#import "InterestsModel.h"
#import "CourseModel.h"


@interface DBAccess : NSObject

- (NSMutableArray*) getAllBuildings;
- (NSMutableArray*) getAllSubjects;

- (NSMutableArray*) getAllGPSLocations;

-(NSMutableArray*) getAllInterests;

- (NSMutableArray*) getAllCoursesGivenSubject;

- (NSMutableArray*) getAllCourses; // adding so I can get at some CourseModel objects for testing


- (void) closeDatabase;
- (void) initializeDatabase;

@end
