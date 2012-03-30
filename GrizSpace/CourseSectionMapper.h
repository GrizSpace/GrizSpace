//
//  CourseSectionMapper.h
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mapper.h"
#import "CourseSection.h"

@interface CourseSectionMapper : Mapper

- (id)init;
- (NSMutableArray*)findByCourseId: (int)courseId;

@end
