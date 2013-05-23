//
//  BallTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#import "BallTest.h"
#import "Ball.h"
#import "PropertyChangedAssertionHelper.h"

@implementation BallTest

- (void)testDX
{
    Ball ball;
    ball.setDX(1.1f);
    STAssertEquals(1.1f, ball.getDX(), @"dx expected %f, but was %f", 1.1f, ball.getDX());
}

- (void)testDX_Notification
{
    PropertyChangedListenerMock listener;
    
    Ball ball;
    ball.addListener(&listener);
    
    ball.setDX(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    ball.setDX(1.1f);
    STAssertPropertyChangedFloat(&listener, &ball, @"dx", 0.0f, 1.1f);
}

- (void)testDY
{
    Ball ball;
    ball.setDY(2.2f);
    STAssertEquals(2.2f, ball.getDY(), @"dy expected %f, but was %f", 2.2f, ball.getDY());
}

- (void)testDY_Notification
{
    PropertyChangedListenerMock listener;
    
    Ball ball;
    ball.addListener(&listener);
    
    ball.setDY(0.0f);
    STAssertPropertyNotChanged(&listener);
    
    ball.setDY(2.2f);
    STAssertPropertyChangedFloat(&listener, &ball, @"dy", 0.0f, 2.2f);
}

@end
