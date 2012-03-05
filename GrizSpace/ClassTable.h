//
//  ClassTable.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassData.h"
@interface ClassTable : NSObject
{
    int currentClassIndex;
}


@property (nonatomic, readwrite) int currentClassIndex;

//this function is used to get the class items.  It can get the next item, current item or prior item.
-(NSMutableArray*) GetClassItems;
-(ClassData*) GetNextClass;
@end

