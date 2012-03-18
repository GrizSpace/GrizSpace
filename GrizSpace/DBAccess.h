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


@interface DBAccess : NSObject

- (NSMutableArray*) getAllBuildings;
- (void) closeDatabase;
- (void) initializeDatabase;

@end
