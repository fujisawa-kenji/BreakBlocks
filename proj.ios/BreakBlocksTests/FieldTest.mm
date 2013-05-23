//
//  FieldTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#import "FieldTest.h"
#import "Field.h"
#import "PropertyChangedAssertionHelper.h"

@implementation FieldTest

- (void)testX
{
    Field field;
    field.setX(1.1f);
    STAssertEquals(1.1f, field.getX(), @"x expected %f, but was %f", 1.1f, field.getX());
}

- (void)testX_Notification
{
    PropertyChangedListenerMock listener;
    
    Field field;
    field.addListener(&listener);
    
    field.setX(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    field.setX(1.1f);
    STAssertPropertyChangedFloat(&listener, &field, @"x", 0.0f, 1.1f);
}

- (void)testY
{
    Field field;
    field.setY(2.2f);
    STAssertEquals(2.2f, field.getY(), @"y expected %f, but was %f", 2.2f, field.getY());
}

- (void)testY_Notification
{
    PropertyChangedListenerMock listener;
    
    Field field;
    field.addListener(&listener);
    
    field.setY(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    field.setY(2.2f);
    STAssertPropertyChangedFloat(&listener, &field, @"y", 0.0f, 2.2f);
}

- (void)testWidth
{
    Field field;
    field.setWidth(3.3f);
    STAssertEquals(3.3f, field.getWidth(), @"width expected %f, but was %f", 3.3f, field.getWidth());
}

- (void)testWidth_Notification
{
    PropertyChangedListenerMock listener;
    
    Field field;
    field.addListener(&listener);
    
    field.setWidth(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    field.setWidth(3.3f);
    STAssertPropertyChangedFloat(&listener, &field, @"width", 0.0f, 3.3f);
}

- (void)testHeight
{
    Field field;
    field.setHeight(4.4f);
    STAssertEquals(4.4f, field.getHeight(), @"height expected %f, but was %f", 4.4f, field.getHeight());
}

- (void)testHeight_Notification
{
    PropertyChangedListenerMock listener;
    
    Field field;
    field.addListener(&listener);
    
    field.setHeight(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    field.setHeight(4.4f);
    STAssertPropertyChangedFloat(&listener, &field, @"height", 0.0f, 4.4f);
}

@end
