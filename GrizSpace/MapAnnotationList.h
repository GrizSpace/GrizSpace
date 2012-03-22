//
//  MapAnnotationList.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapAnnotation.h"

@interface MapAnnotationList : NSObject
{
    //int currentAnnotationIndex; //the currently selected annotation index
}

//@property (nonatomic, readwrite) bool currentAnnotationIndexSet; //used to determin if the current annotation index is set.
@property (nonatomic, readwrite) NSMutableArray* myAnnotationItems; //gets the list of annotation items

-(MapAnnotation*) GetNextAnnotation; //gets the next annotation item
-(MapAnnotation*) GetCurrentAnnotation; //gets the current annotation item

@end