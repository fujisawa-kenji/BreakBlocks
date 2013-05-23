//
//  RetainableObjectTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/12.
//
//

#import "RetainableObjectTest.h"
#import "RetainableObject.h"

@implementation RetainableObjectTest

- (void)testRetainRelease
{
    auto obj = new RetainableObject();
    STAssertEquals(0, obj->getReferenceCount(), @"referenceCount expected %d, but was %d", 1, obj->getReferenceCount());
    
    obj->retain();
    STAssertEquals(1, obj->getReferenceCount(), @"referenceCount expected %d, but was %d", 2, obj->getReferenceCount());
    
    obj->retain();
    STAssertEquals(2, obj->getReferenceCount(), @"referenceCount expected %d, but was %d", 1, obj->getReferenceCount());
    
    obj->release();
    STAssertEquals(1, obj->getReferenceCount(), @"referenceCount expected %d, but was %d", 1, obj->getReferenceCount());
    
    obj->release();
}

@end
