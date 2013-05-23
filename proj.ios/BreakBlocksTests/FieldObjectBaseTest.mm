//
//  FieldObjectBaseTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#import "FieldObjectBaseTest.h"
#import "FieldObjectBase.h"
#import "PropertyChangedAssertionHelper.h"

@implementation FieldObjectBaseTest

- (void)testCenterX
{
    FieldObjectBase obj;
    obj.setCenterX(1.1f);
    STAssertEquals(1.1f, obj.getCenterX(), @"expected %f, but was %f", 1.1f, obj.getCenterX());
}

- (void)testCenterX_Notification
{
    PropertyChangedListenerMock listener;
    
    FieldObjectBase obj;
    obj.addListener(&listener);
    
    obj.setCenterX(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    obj.setCenterX(1.1f);
    STAssertPropertyChangedFloat(&listener, &obj, @"centerX", 0.0f, 1.1f);
}

- (void)testCenterY
{
    FieldObjectBase obj;
    obj.setCenterY(2.2f);
    STAssertEquals(2.2f, obj.getCenterY(), @"expected %f, but was %f", 2.2f, obj.getCenterY());
}

- (void)testCenterY_Notification
{
    PropertyChangedListenerMock listener;
    
    FieldObjectBase obj;
    obj.addListener(&listener);
    
    obj.setCenterY(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    obj.setCenterY(2.2f);
    STAssertPropertyChangedFloat(&listener, &obj, @"centerY", 0.0f, 2.2f);
}

- (void)testWidth
{
    FieldObjectBase obj;
    obj.setWidth(3.3f);
    STAssertEquals(3.3f, obj.getWidth(), @"expected %f, but was %f", 3.3f, obj.getWidth());
}

- (void)testWidth_Notification
{
    PropertyChangedListenerMock listener;
    
    FieldObjectBase obj;
    obj.addListener(&listener);
    
    obj.setWidth(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    obj.setWidth(3.3f);
    STAssertPropertyChangedFloat(&listener, &obj, @"width", 0.0f, 3.3f);
}

- (void)testHeight
{
    FieldObjectBase obj;
    obj.setHeight(4.4f);
    STAssertEquals(4.4f, obj.getHeight(), @"expected %f, but was %f", 4.4f, obj.getHeight());
}

- (void)testHeight_Notification
{
    PropertyChangedListenerMock listener;
    
    FieldObjectBase obj;
    obj.addListener(&listener);
    
    obj.setHeight(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    obj.setHeight(4.4f);
    STAssertPropertyChangedFloat(&listener, &obj, @"height", 0.0f, 4.4f);
}

- (void)testIntersectsWith_NotIntersects
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(10.0f);
    obj1.setCenterY(10.0f);
    obj1.setWidth(10.0f);
    obj1.setHeight(10.0f);
    
    obj2.setCenterX(50.0f);
    obj2.setCenterY(50.0f);
    obj2.setWidth(10.0f);
    obj2.setHeight(10.0f);
    
    STAssertFalse(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected false, but was true");
    STAssertFalse(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected false, but was true");
}

- (void)testIntersectsWith_Inside
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(100.0f);
    obj1.setCenterY(100.0f);
    obj1.setWidth(50.0f);
    obj1.setHeight(50.0f);
    
    obj2.setCenterX(80.0f);
    obj2.setCenterY(80.0f);
    obj2.setWidth(10.0f);
    obj2.setHeight(10.0f);
    
    STAssertTrue(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected true, but was false");
    STAssertTrue(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected true, but was false");
}

- (void)testIntersectsWith_IntersectsLeft_Right
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(50.0f);
    obj1.setCenterY(50.0f);
    obj1.setWidth(50.0f);
    obj1.setHeight(50.0f);
    
    obj2.setCenterX(80.0f);
    obj2.setCenterY(50.0f);
    obj2.setWidth(30.0f);
    obj2.setHeight(30.0f);
    
    STAssertTrue(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected true, but was false");
    STAssertTrue(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected true, but was false");
}

- (void)testIntersectsWith_IntersectsTop_Bottom
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(50.0f);
    obj1.setCenterY(50.0f);
    obj1.setWidth(50.0f);
    obj1.setHeight(50.0f);
    
    obj2.setCenterX(50.0f);
    obj2.setCenterY(80.0f);
    obj2.setWidth(30.0f);
    obj2.setHeight(30.0f);
    
    STAssertTrue(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected true, but was false");
    STAssertTrue(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected true, but was false");
}

- (void)testIntersectsWith_IntersectsTopRight_BottomLeft
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(50.0f);
    obj1.setCenterY(50.0f);
    obj1.setWidth(50.0f);
    obj1.setHeight(50.0f);
    
    obj2.setCenterX(80.0f);
    obj2.setCenterY(80.0f);
    obj2.setWidth(50.0f);
    obj2.setHeight(50.0f);
    
    STAssertTrue(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected true, but was false");
    STAssertTrue(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected true, but was false");
}

- (void)testIntersectsWith_IntersectsTopLeft_BottomRight
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(100.0f);
    obj1.setCenterY(50.0f);
    obj1.setWidth(50.0f);
    obj1.setHeight(50.0f);
    
    obj2.setCenterX(70.0f);
    obj2.setCenterY(80.0f);
    obj2.setWidth(50.0f);
    obj2.setHeight(50.0f);
    
    STAssertTrue(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected true, but was false");
    STAssertTrue(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected true, but was false");
}

- (void)testIntersectsWith_Contact
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(50.0f);
    obj1.setCenterY(50.0f);
    obj1.setWidth(50.0f);
    obj1.setHeight(50.0f);
    
    obj2.setCenterX(100.0f);
    obj2.setCenterY(100.0f);
    obj2.setWidth(50.0f);
    obj2.setHeight(50.0f);
    
    STAssertTrue(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected true, but was false");
    STAssertTrue(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected true, but was false");
}

- (void)testIntersectsWith_Overlap
{
    FieldObjectBase obj1;
    FieldObjectBase obj2;
    
    obj1.setCenterX(50.0f);
    obj1.setCenterY(50.0f);
    obj1.setWidth(50.0f);
    obj1.setHeight(50.0f);
    
    obj2.setCenterX(50.0f);
    obj2.setCenterY(50.0f);
    obj2.setWidth(50.0f);
    obj2.setHeight(50.0f);
    
    STAssertTrue(obj1.intersectsWith(&obj2), @"obj1.intersectsWith(obj2) expected true, but was false");
    STAssertTrue(obj2.intersectsWith(&obj1), @"obj2.intersectsWith(obj1) expected true, but was false");
}

- (void)testInsideOf_Inside
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(50.0f);
    obj.setCenterY(50.0f);
    obj.setWidth(10.0f);
    obj.setHeight(10.0f);
    
    STAssertTrue(obj.insideOf(&field), @"obj.insideOf(field) expected true, but was false");
}

- (void)testInsideOf_Outside
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(0.0f);
    obj.setCenterY(0.0f);
    obj.setWidth(10.0f);
    obj.setHeight(10.0f);
    
    STAssertFalse(obj.insideOf(&field), @"obj.insideOf(field) expected false, but was true");
}

- (void)testInsideOf_IntersectLeft
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(5.0f);
    obj.setCenterY(50.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertFalse(obj.insideOf(&field), @"obj.insideOf(field) expected false, but was true");
}

- (void)testInsideOf_IntersectRight
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(115.0f);
    obj.setCenterY(50.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertFalse(obj.insideOf(&field), @"obj.insideOf(field) expected false, but was true");
}

- (void)testInsideOf_IntersectTop
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(50.0f);
    obj.setCenterY(115.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertFalse(obj.insideOf(&field), @"obj.insideOf(field) expected false, but was true");
}

- (void)testInsideOf_IntersectBottom
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(50.0f);
    obj.setCenterY(5.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertFalse(obj.insideOf(&field), @"obj.insideOf(field) expected false, but was true");
}

- (void)testInsideOf_ContactTopLeft
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(20.0f);
    obj.setCenterY(100.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertTrue(obj.insideOf(&field), @"obj.insideOf(field) expected true, but was false");
}

- (void)testInsideOf_ContactTopRight
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(100.0f);
    obj.setCenterY(100.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertTrue(obj.insideOf(&field), @"obj.insideOf(field) expected true, but was false");
}

- (void)testInsideOf_ContactBottomRight
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(100.0f);
    obj.setCenterY(20.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertTrue(obj.insideOf(&field), @"obj.insideOf(field) expected true, but was false");
}

- (void)testInsideOf_ContactBottomLeft
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(10.0f);
    field.setY(10.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(20.0f);
    obj.setCenterY(20.0f);
    obj.setWidth(20.0f);
    obj.setHeight(20.0f);
    
    STAssertTrue(obj.insideOf(&field), @"obj.insideOf(field) expected true, but was false");
}

- (void)testInsideOf_OverSize
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(0.0f);
    field.setY(0.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(50.0f);
    obj.setCenterY(50.0f);
    obj.setWidth(110.0f);
    obj.setHeight(110.0f);
    
    STAssertFalse(obj.insideOf(&field), @"obj.insideOf(field) expected false, but was true");
}

- (void)testInsideOf_Overlap
{
    Field field;
    FieldObjectBase obj;
    
    field.setX(0.0f);
    field.setY(0.0f);
    field.setWidth(100.0f);
    field.setHeight(100.0f);
    
    obj.setCenterX(50.0f);
    obj.setCenterY(50.0f);
    obj.setWidth(100.0f);
    obj.setHeight(100.0f);
    
    STAssertTrue(obj.insideOf(&field), @"obj.insideOf(field) expected true, but was false");
}

@end
