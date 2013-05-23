//
//  PropertyChangedAssertionHelper.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#ifndef __BreakBlocks__PropertyChangedAssertionHelper__
#define __BreakBlocks__PropertyChangedAssertionHelper__

#include "IPropertyChangedListener.h"
#include "PropertyChangedEventArgsBase.h"
#include <typeinfo>

#define STAssertPropertyChanged(listener, _sender, propertyName, oldValue, newValue) \
    STAssertTrue( \
        (listener)->called, \
        @"listener was not called"); \
    STAssertTrue( \
        (listener)->sender == (_sender), \
        @"sender expected %s, but was %s", \
        typeid((_sender)).name(), \
        typeid((listener)->sender).name()); \
    STAssertTrue( \
        strcmp([(propertyName) UTF8String], ((PropertyChangedEventArgs<void*>*)(listener)->e)->getPropertyName()) == 0, \
        @"propertyName expected %s, but was %s", \
        [(propertyName) UTF8String], \
        ((PropertyChangedEventArgs<void*>*)(listener)->e)->getPropertyName()); \
    STAssertTrue( \
        (oldValue) == ((PropertyChangedEventArgs<void*>*)(listener)->e)->getOldValue(), \
        @"oldValue expected %s, but was %s", \
        typeid((oldValue)).name(), \
        typeid(((PropertyChangedEventArgs<void*>*)(listener)->e)->getOldValue()).name()); \
    STAssertTrue( \
        (newValue) == ((PropertyChangedEventArgs<void*>*)(listener)->e)->getNewValue(), \
        @"newValue expected %s, but was %s", \
        typeid((newValue)).name(), \
        typeid(((PropertyChangedEventArgs<void*>*)(listener)->e)->getNewValue()).name());

#define STAssertPropertyChangedInt(listener, _sender, propertyName, oldValue, newValue) \
    STAssertTrue( \
    (listener)->called, \
    @"listener was not called"); \
    STAssertTrue( \
    (listener)->sender == (_sender), \
    @"sender expected %s, but was %s", \
    typeid((_sender)).name(), \
    typeid((listener)->sender).name()); \
    STAssertTrue( \
    strcmp([(propertyName) UTF8String], ((PropertyChangedEventArgs<int>*)(listener)->e)->getPropertyName()) == 0, \
    @"propertyName expected %s, but was %s", \
    [(propertyName) UTF8String], \
    ((PropertyChangedEventArgs<int>*)(listener)->e)->getPropertyName()); \
    STAssertEquals( \
    (oldValue), \
    ((PropertyChangedEventArgs<int>*)(listener)->e)->getOldValue(), \
    @"oldValue expected %d, but was %d", \
    (oldValue), \
    ((PropertyChangedEventArgs<int>*)(listener)->e)->getOldValue()); \
    STAssertEquals( \
    (newValue), \
    ((PropertyChangedEventArgs<int>*)(listener)->e)->getNewValue(), \
    @"newValue expected %d, but was %d", \
    (newValue), \
    ((PropertyChangedEventArgs<int>*)(listener)->e)->getNewValue());

#define STAssertPropertyChangedFloat(listener, _sender, propertyName, oldValue, newValue) \
    STAssertTrue( \
        (listener)->called, \
        @"listener was not called"); \
    STAssertTrue( \
        (listener)->sender == (_sender), \
        @"sender expected %s, but was %s", \
        typeid((_sender)).name(), \
        typeid((listener)->sender).name()); \
    STAssertTrue( \
        strcmp([(propertyName) UTF8String], ((PropertyChangedEventArgs<float>*)(listener)->e)->getPropertyName()) == 0, \
        @"propertyName expected %s, but was %s", \
        [(propertyName) UTF8String], \
        ((PropertyChangedEventArgs<float>*)(listener)->e)->getPropertyName()); \
    STAssertEquals( \
        (oldValue), \
        ((PropertyChangedEventArgs<float>*)(listener)->e)->getOldValue(), \
        @"oldValue expected %f, but was %f", \
        (oldValue), \
        ((PropertyChangedEventArgs<float>*)(listener)->e)->getOldValue()); \
    STAssertEquals( \
        (newValue), \
        ((PropertyChangedEventArgs<float>*)(listener)->e)->getNewValue(), \
        @"newValue expected %f, but was %f", \
        (newValue), \
        ((PropertyChangedEventArgs<float>*)(listener)->e)->getNewValue());

#define STAssertPropertyChangedChar(listener, _sender, propertyName, oldValue, newValue) \
    STAssertTrue( \
        (listener)->called, \
        @"listener was not called"); \
    STAssertTrue( \
        (listener)->sender == (_sender), \
        @"sender expected %s, but was %s", \
        typeid((_sender)).name(), \
        typeid((listener)->sender).name()); \
    STAssertTrue( \
        strcmp([(propertyName) UTF8String], ((PropertyChangedEventArgs<const char*>*)(listener)->e)->getPropertyName()) == 0, \
        @"propertyName expected %s, but was %s", \
        [(propertyName) UTF8String], \
        ((PropertyChangedEventArgs<const char*>*)(listener)->e)->getPropertyName()); \
    STAssertTrue( \
        strcmp((oldValue), ((PropertyChangedEventArgs<const char*>*)(listener)->e)->getOldValue()) == 0, \
        @"oldValue expected %s, but was %s", \
        (oldValue), \
        ((PropertyChangedEventArgs<const char*>*)(listener)->e)->getOldValue()); \
    STAssertTrue( \
        strcmp((newValue), ((PropertyChangedEventArgs<const char*>*)(listener)->e)->getNewValue()) == 0, \
        @"newValue expected %s, but was %s", \
        (newValue), \
        ((PropertyChangedEventArgs<const char*>*)(listener)->e)->getNewValue());

#define STAssertPropertyNotChanged(listener) \
    STAssertFalse((listener)->called, @"listener was called");

class PropertyChangedListenerMock : public IPropertyChangedListener
{
public:
    bool called;
    void* sender;
    PropertyChangedEventArgsBase* e;
    
    PropertyChangedListenerMock();
    ~PropertyChangedListenerMock();
    
    virtual void propertyChanged(void* sender, PropertyChangedEventArgsBase* e);
};

#endif /* defined(__BreakBlocks__PropertyChangedAssertionHelper__) */
