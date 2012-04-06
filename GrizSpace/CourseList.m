//
//  CourseList.m
//  GrizSpace
//
//  Created by William Lyon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseList.h"

@implementation CourseList

@synthesize myCourseItems;
-(id) init
{
    //myCourseItems = [self.getCourseList mutableCopy];
    currentCourseIndex = 0; //default course is first one.
    return self;
}

+(void) removeCourse:(CourseModel *)courseToBeRemoved
{
    PFQuery* query = [PFQuery queryWithClassName:@"CourseModel"];
    NSString* objectID = [courseToBeRemoved getParseObjectID];
    PFObject *courseToDelete = [query getObjectWithId:objectID];
    [courseToDelete delete];
}

+(void) addCourse:(CourseModel*) courseToBeAdded inSubject:(SubjectModel *)subjToBeAdded
{
    PFObject *PFcourseToBeAdded = [PFObject objectWithClassName:@"CourseModel"];
    
    [PFcourseToBeAdded setObject:[[UIDevice currentDevice] uniqueIdentifier] forKey:@"userid"];
    
    [PFcourseToBeAdded setObject:[courseToBeAdded getNumber] forKey:@"number"];
    [PFcourseToBeAdded setObject:[subjToBeAdded getAbbr] forKey:@"subject"];
    [PFcourseToBeAdded setObject:[NSNumber numberWithInt:courseToBeAdded.section.days] forKey:@"days"];
    
    
    [PFcourseToBeAdded setObject:courseToBeAdded.section.startTime forKey:@"startTime"];
    [PFcourseToBeAdded setObject:courseToBeAdded.section.endTime forKey:@"endTime"];
    [PFcourseToBeAdded setObject:courseToBeAdded.section.getNumberString forKey:@"sectionNumber"];
    
    [PFcourseToBeAdded setObject:courseToBeAdded.section.room forKey:@"room"];
    [PFcourseToBeAdded setObject:courseToBeAdded.section.building forKey:@"building"];
    [PFcourseToBeAdded setObject:[NSNumber numberWithDouble:courseToBeAdded.section.longitude] forKey:@"longitude"];
    [PFcourseToBeAdded setObject:[NSNumber numberWithDouble:courseToBeAdded.section.latitude] forKey:@"latitude"];
    
    [PFcourseToBeAdded save];
    
}


-(NSMutableArray*) getCourseListFromParse
{
 // TODO: all parse calls need to run on background threads  
    NSMutableArray* tmpCourseList = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"CourseModel"];
    [query whereKey:@"userid" equalTo:[[UIDevice currentDevice] uniqueIdentifier]];
    
    NSLog(@"%@", [[UIDevice currentDevice] uniqueIdentifier]);
           
    NSArray* PFObjectCourseArray = [query findObjects];
    
    for (int i=0; i<[PFObjectCourseArray count];i++)
    {
        CourseModel* tmpCourse = [[CourseModel alloc] init];
        [tmpCourse setSubject:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"subject"]];
         
        [tmpCourse setNumber:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"number"]];
        [tmpCourse setParseObjectID:((PFObject*)[PFObjectCourseArray objectAtIndex:i]).objectId];
        
        [tmpCourse setUserid:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"userid"]];
        
        
        CourseSection *tmpSection = [[CourseSection alloc] 
                                     initWithCrn:nil 
                                     andSection:[[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"sectionNumber"] intValue] 
                                     thatStarts:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"startTime"] 
                                     andEnds:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"endTime"] 
                                     on:[[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"days"] intValue] 
                                     inBuilding:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"building"] 
                                     inRoom:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"room"] 
                                     atLongitude:[[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"longitude"] doubleValue]
                                     andLatitude:[[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"latitude"] doubleValue]];
        
        [tmpCourse setSection:tmpSection];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
        /*
        tmpCourse.section.number = (int)[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"sectionNumber"]; //not sure if this casting will result in the correct value, need to confirm 
        [tmpCourse.section setStartTime:[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"startTime"]];
         
        tmpCourse.section.endTime = [[PFObjectCourseArray objectAtIndex:i] objectForKey:@"endTime"];
        tmpCourse.section.days = [[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"days"] intValue];
        tmpCourse.section.building = [[PFObjectCourseArray objectAtIndex:i] objectForKey:@"building"]; 
        [tmpCourse.section setRoom: [[PFObjectCourseArray objectAtIndex:i] objectForKey:@"room"]];
        
        tmpCourse.section.latitude = [[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
        
        tmpCourse.section.longitude = [[[PFObjectCourseArray objectAtIndex:i] objectForKey:@"longitude"] doubleValue]; 
        */
        NSLog(@"building: %@", tmpCourse.section.building);
        NSLog(@"room: %@", tmpCourse.section.room);
        NSLog(@"latitude: %f", tmpCourse.section.latitude);
        NSLog(@"section number: %d", tmpCourse.section.number);
        
        [tmpCourseList addObject:tmpCourse];
        
    }
    
    
    return tmpCourseList;
}


//-(NSMutableArray*) getCourseList // populate and return an array of CourseModel objects
                                // CURRENTLY JUST DUMMY VALUES, USED FOR TESTING, NOT PULLING FROM DB
//{
//    return [self getCourseListFromParse];
    /*
    NSArray* subjects = [[NSArray alloc] initWithObjects:@"Economics", @"Computer Science", @"Mathematics", nil];
    
    NSArray* subjAbbrs = [[NSArray alloc] initWithObjects:@"ECON", @"CSCI", @"M", nil];
    
    NSArray* numbers = [[NSArray alloc] initWithObjects:@"311", @"576", @"225", nil];
    
    NSArray* titles = [[NSArray alloc] initWithObjects:@"Intermediate Microeconomics", @"Human Computer Interaction", @"Discrete Mathematics", nil];
    
    NSArray* days = [[NSArray alloc] initWithObjects:@"MWF", @"TTh", @"MWF", nil];
    
    NSArray* times = [[NSArray alloc] initWithObjects:@"8:10-9:00", @"12:10-1:30", @"11:10-12:00", nil];
    
    NSArray* buildingAndRooms= [[NSArray alloc] initWithObjects:@"GBB L09", @"LA 311", @"SS 362", nil];
    
    NSArray* longitudes = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:-113.988385], [NSNumber numberWithDouble:-113.987379],[NSNumber numberWithDouble:-113.985247], nil];
    
    NSArray* latitudes = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:46.8579], [NSNumber numberWithDouble:46.86078],[NSNumber numberWithDouble:46.862683], nil];
    
    NSArray* indexes = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
    
    
    NSMutableArray* myCourses = [[NSMutableArray alloc] init ];
    
    for (int i=0;i<3;i++)
    {
        CourseModel* tmpCourse = [[CourseModel alloc] init];
        [tmpCourse setSubject:[subjects objectAtIndex:i]];
        [tmpCourse setSubjAbbr:[subjAbbrs objectAtIndex:i]];
        [tmpCourse setNumber:[numbers objectAtIndex:i]];
        [tmpCourse setTitle:[titles objectAtIndex:i]];
        [tmpCourse setDays:[days objectAtIndex:i]];
        [tmpCourse setTime:[times objectAtIndex:i]];
        [tmpCourse setBuildingAndRoom:[buildingAndRooms objectAtIndex:i]];
        
        [tmpCourse setLatitude:[[latitudes objectAtIndex:i ] doubleValue]];
         
        [tmpCourse setLongitude:[[longitudes objectAtIndex:i ] doubleValue]];
        
        [tmpCourse setIndex:[[indexes objectAtIndex:i] integerValue]];
        
        
         
        [myCourses addObject:tmpCourse];
        
        
    }
    
    return myCourses;
     */
//}

+(NSMutableArray*) getMyCourseList
{
    return [[NSMutableArray alloc] init];
}


//gets the next class from the class list.
-(CourseModel*) GetNextCourse
{
    
     if(currentCourseIndex == ([myCourseItems count] - 1))
     {
        currentCourseIndex = 0;
     }
     else 
     {
         currentCourseIndex = currentCourseIndex + 1;
     }
     
    return self.GetCurrentCourse;
}

//gets the current annotation item.
-(CourseModel*) GetCurrentCourse
{
    return [myCourseItems objectAtIndex: currentCourseIndex];
}



@end


