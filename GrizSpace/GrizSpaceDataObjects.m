//
//  GrizSpaceDataObjects.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GrizSpaceDataObjects.h"
#import "ClassTable.h"

@implementation GrizSpaceDataObjects

ClassTable* myClassTable;
//default constructor
-(id) init {
    
    if (self = [super init])
    {
        //create instance of the class table.
        myClassTable = [[ClassTable alloc ] init];
        
    }
    return self;
    
}

//returns the class table object from the space of stored data objects.
-(ClassTable*) GetClassTable
{
    return myClassTable;
}

@end
