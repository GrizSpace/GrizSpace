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
    self->cs = [[CourseSection alloc] initWithCrn:666
                                       andSection:7
                                       thatStarts:@"0910"
                                          andEnds:@"1000"
                                               on:15 // MTWR
                                       inBuilding:@"SS"
                                           inRoom:@"362"
                                      atLongitude:0.0
                                      andLatitude:0.0];
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
    STAssertEqualObjects([cs startTime], @"0910", @"Start time is incorrect");
}

- (void)testEndTime
{
    STAssertEqualObjects([cs endTime], @"1000", @"End time is incorrect");
}

- (void)testDays
{
    STAssertEqualObjects([cs getDays], @"MTWR", @"Bitmask to string is incorrect");
}

- (void)testIsOnMonday
{
    STAssertTrue([cs isOnMonday], @"Class should be on Monday");
}

- (void)testIsOnTuesday
{
    STAssertTrue([cs isOnTuesday], @"Class should be on Tuesday");
}

- (void)testIsOnWednesday
{
    STAssertTrue([cs isOnWednesday], @"Class should be on Wednesday");
}

- (void)testIsOnThursday
{
    STAssertTrue([cs isOnThursday], @"Class should be on Thursday");
}

- (void)testIsOnFriday
{
    STAssertFalse([cs isOnFriday], @"Class should not be on Friday");
}

- (void)testIsOnSaturday
{
    STAssertFalse([cs isOnSaturday], @"Class should not be on Saturday");
}

- (void)testIsOnSunday
{
    STAssertFalse([cs isOnSunday], @"Class should not be on Sunday");
}

- (void)testGetOccurrences
{
    STAssertEquals([cs getOccurrences], 4, @"Class has four sessions");
}

@end