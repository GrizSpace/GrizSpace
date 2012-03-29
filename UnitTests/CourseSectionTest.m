#import <SenTestingKit/SenTestingKit.h>
#import "CourseSection.h"

@interface CourseSectionTest : SenTestCase
{
    CourseSection* cs;
}
@end

@implementation CourseSectionTest

- (void)setUp
{
    self->cs = [[CourseSection alloc] initWithCrn:666 andSection:7 
                                       thatStarts:@"0910" andEnds:@"1000" on:15];
}

- (void)testCrn
{
    STAssertEquals([cs crn], 666, @"CRN is incorrect");
}

- (void)testNumber
{
    STAssertEquals([cs number], 7, @"Section # is incorrect");
}

- (void)testStartTime
{
    STAssertEquals([cs startTime], @"0910", @"Start time is incorrect");
}

- (void)testEndTime
{
    STAssertEquals([cs endTime], @"1000", @"End time is incorrect");
}

- (void)testDays
{
    STAssertEqualObjects([cs getDays], @"MTWR", @"Bitmask to string is incorrect");
}

@end