#import <SenTestingKit/SenTestingKit.h>
#import "CourseSection.h"
#import "CourseSectionMapper.h"

// TODO: Switch to a testing DB to ensure the courses exist
@interface CourseSectionMapperTest : SenTestCase
{
    CourseSectionMapper* table;
}
@end

@implementation CourseSectionMapperTest

- (void)setUp
{
    self->table = [[CourseSectionMapper alloc] init];
}

- (void)testFindByCourseId
{
    NSMutableArray* results = [table findByCourseId:1];
    CourseSection* first = [results objectAtIndex:0];
    STAssertEquals([first crn], 35114, @"Should be ARTZ 108A");
    STAssertEqualObjects([first startTime], @"0900", @"Should be ARTZ 108A");
    STAssertEqualObjects([first getDays], @"MTWRF", @"Should be each weekday");
}

@end
