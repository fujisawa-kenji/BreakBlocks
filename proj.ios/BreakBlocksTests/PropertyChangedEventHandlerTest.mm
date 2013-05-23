//
//  PropertyChangedEventHandlerTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/19.
//
//

#import "PropertyChangedEventHandlerTest.h"

@implementation PropertyChangedEventHandlerTest

- (void)testPropertyChanged
{
    NotifyPropertyChangedMock notifier;
    PropertyChangedEventHandlerMock mock;
    PropertyChangedEventHandler<PropertyChangedEventHandlerMock> handler;
    handler.setDelegate(&mock, &PropertyChangedEventHandlerMock::propertyChanged);
    
    notifier.addListener(&handler);
    notifier.callOnPropertyChanged();
    STAssertTrue(mock.called, @"handler is not called");
}

@end

PropertyChangedEventHandlerMock::PropertyChangedEventHandlerMock()
{
    this->called = false;
}

void PropertyChangedEventHandlerMock::propertyChanged(void *sender, PropertyChangedEventArgsBase *e)
{
    this->called = true;
}

void NotifyPropertyChangedMock::callOnPropertyChanged()
{
    this->onPropertyChanged("");
}
