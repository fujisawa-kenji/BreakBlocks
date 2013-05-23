//
//  NotifyPropertyChangedBaseTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/04.
//
//

#import "NotifyPropertyChangedBaseTest.h"
#import "PropertyChangedEventArgs.h"
#import "PropertyChangedAssertionHelper.h"

@implementation NotifyPropertyChangedBaseTest

- (void)testNotify
{
    PropertyChangedListenerMock listener1;
    PropertyChangedListenerMock listener2;
    
    NotifyPropertyChangedMock sender;
    sender.addListener(&listener1);
    sender.addListener(&listener2);
    
    const char* propertyName = [@"foo" UTF8String];
    sender.callOnPropertyChanged(propertyName);
    
    STAssertPropertyChanged(&listener1, &sender, @"foo", NULL, NULL);
    STAssertPropertyChanged(&listener2, &sender, @"foo", NULL, NULL);
}

- (void)testNotifyFloat
{
    PropertyChangedListenerMock listener1;
    PropertyChangedListenerMock listener2;
    
    NotifyPropertyChangedMock sender;
    sender.addListener(&listener1);
    sender.addListener(&listener2);
    
    sender.callOnPropertyChanged([@"foo" UTF8String], 1.1f, 2.2f);
    
    STAssertPropertyChangedFloat(&listener1, &sender, @"foo", 1.1f, 2.2f);
    STAssertPropertyChangedFloat(&listener2, &sender, @"foo", 1.1f, 2.2f);
}

- (void)testNotifyChar
{
    PropertyChangedListenerMock listener1;
    PropertyChangedListenerMock listener2;
    
    NotifyPropertyChangedMock sender;
    sender.addListener(&listener1);
    sender.addListener(&listener2);
    
    const char* oldValue = [@"hoge" UTF8String];
    const char* newValue = [@"fuga" UTF8String];
    sender.callOnPropertyChanged([@"foo" UTF8String], oldValue, newValue);
    
    STAssertPropertyChangedChar(&listener1, &sender, @"foo", oldValue, newValue);
    STAssertPropertyChangedChar(&listener2, &sender, @"foo", oldValue, newValue);
}

@end

void NotifyPropertyChangedMock::callOnPropertyChanged(const char* propertyName)
{
    this->onPropertyChanged(propertyName);
}

void NotifyPropertyChangedMock::callOnPropertyChanged(const char* propertyName, float oldValue, float newValue)
{
    this->onPropertyChanged<float>(propertyName, oldValue, newValue);
}

void NotifyPropertyChangedMock::callOnPropertyChanged(const char *propertyName, const char* oldValue, const char* newValue)
{
    this->onPropertyChanged<const char*>(propertyName, oldValue, newValue);
}
