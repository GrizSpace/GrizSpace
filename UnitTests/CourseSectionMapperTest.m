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

- (void)testGetFirst
{
    CourseSection* cs = [[CourseSection alloc] initWithCrn:35114 andSection:7
                                                thatStarts:@"0910"
                                                   andEnds:@"1000" on:15];

    STAssertEquals([[table getFirst] crn], [cs crn], @"CRN should be equal");
}

@end
