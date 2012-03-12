//
//  ClassTable.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClassTable.h"
#import "ClassData.h"

@implementation ClassTable

NSMutableArray* myClassItems;
@synthesize currentClassIndex;

-(id) init {
    self = [super init];
    
    //define the array of class items.
    myClassItems = [[NSMutableArray alloc] init]; 
    currentClassIndex = 0;
    //add some testing classes to the class table.
    
    [myClassItems addObject: [[ClassData alloc] initWithClassDataID:1 Name:@"LA 402" Number:@"511" Title:@"Advanced Micro Economics 511" Prefix:@"ECON511" Lat:46.860917 Lon:-113.985968]];
    
    [myClassItems addObject: [[ClassData alloc] initWithClassDataID:2 Name:@"CSCI 101" Number:@"101" Title:@"Intro to Java" Prefix:@"CS101" Lat:46.861748 Lon:-113.985212]];
    
    [myClassItems addObject: [[ClassData alloc] initWithClassDataID:3 Name:@"Main Hall" Number:@"" Title:@"Main Hall" Prefix:@"MH" Lat:46.860097 Lon:-113.983785]];
    	
    
    [myClassItems addObject: [[ClassData alloc] initWithClassDataID:4 Name:@"Art 135" Number:@"135" Title:@"Intro to Art" Prefix:@"ART135" Lat:46.860917 Lon:-113.985968]];
    
    [myClassItems addObject: [[ClassData alloc] initWithClassDataID:5 Name:@"FOR 147" Number:@"147" Title:@"Intro to Forestry" Prefix:@"CS147" Lat:46.858891 Lon:-113.983798]];
    
    
    [myClassItems addObject: [[ClassData alloc] initWithClassDataID:6 Name:@"Rock Climbing Wall" Number:@"1" Title:@"Adams Center" Prefix:@"AC" Lat:46.863815 Lon:-113.983442]];
    
    
    return self;
}

//gets the list of class items.
-(NSMutableArray*) GetClassItems
{
    return myClassItems;
}

//gets the next class from the class list.
-(ClassData*) GetNextClass
{
    if(currentClassIndex == ([myClassItems count] - 1))
    {
        currentClassIndex = 0;
    }
    else 
    {
        currentClassIndex = currentClassIndex + 1;
    }
    return [myClassItems objectAtIndex: currentClassIndex];
}

@end
