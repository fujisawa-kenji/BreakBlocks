//
//  PropertyChangedEventArgsTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/03.
//
//

#import "PropertyChangedEventArgsTest.h"
#import "PropertyChangedEventArgs.h"

@implementation PropertyChangedEventArgsTest

- (void)testGetPropertyName
{
    string str = "foo";
    PropertyChangedEventArgs<int> obj(str.c_str(), 0, 1);
    STAssertTrue(strcmp(str.c_str(), obj.getPropertyName()) == 0, @"propertyName expected %s, but was %s", str.c_str(), obj.getPropertyName());
}

- (void)testGetOldValue
{
    PropertyChangedEventArgs<double> obj("foo", 1.1, 2.2);
    STAssertEquals(1.1, obj.getOldValue(), @"oldValue expected %f, but was %f", 1.1, obj.getOldValue());
}

- (void)testGetNewValue
{
    const char* oldValue = [@"foo" UTF8String];
    const char* newValue = [@"bar" UTF8String];
    PropertyChangedEventArgs<const char*> obj("hoge", oldValue, newValue);
    STAssertTrue(strcmp(newValue, obj.getNewValue()) == 0, @"newValue expected %s, but was %s", newValue, obj.getNewValue());
}

@end
