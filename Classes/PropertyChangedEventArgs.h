//
//  PropertyChangedEventArgs.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/03.
//
//

#ifndef __BreakBlocks__PropertyChangedEventArgs__
#define __BreakBlocks__PropertyChangedEventArgs__

#include <string>
#include "PropertyChangedEventArgsBase.h"

template <class T>
class PropertyChangedEventArgs : public PropertyChangedEventArgsBase
{
private:
    T oldValue;
    T newValue;
    
public:
    PropertyChangedEventArgs(const char* propertyName, T oldValue, T newValue);
    virtual ~PropertyChangedEventArgs();
    
    T getOldValue();
    T getNewValue();
};

template <class T>
PropertyChangedEventArgs<T>::PropertyChangedEventArgs(const char* propertyName, T oldValue, T newValue)
: PropertyChangedEventArgsBase(propertyName)
, oldValue(oldValue)
, newValue(newValue)
{
}

template <class T>
PropertyChangedEventArgs<T>::~PropertyChangedEventArgs()
{
}

template <class T>
T PropertyChangedEventArgs<T>::getOldValue()
{
    return this->oldValue;
}

template <class T>
T PropertyChangedEventArgs<T>::getNewValue()
{
    return this->newValue;
}

#endif /* defined(__BreakBlocks__PropertyChangedEventArgs__) */
