//
//  NotifyPropertyChangedBase.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/03.
//
//

#include "NotifyPropertyChangedBase.h"

NotifyPropertyChangedBase::~NotifyPropertyChangedBase()
{
}

void NotifyPropertyChangedBase::addListener(IPropertyChangedListener* listener)
{
    this->listeners.push_back(listener);
}

void NotifyPropertyChangedBase::onPropertyChanged(const char* propertyName)
{
    auto e = new PropertyChangedEventArgs<void*>(propertyName, NULL, NULL);
    this->onPropertyChanged(e);
}
