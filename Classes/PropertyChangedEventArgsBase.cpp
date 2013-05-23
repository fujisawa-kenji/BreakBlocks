//
//  PropertyChangedEventArgsBase.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/05.
//
//

#include "PropertyChangedEventArgsBase.h"

PropertyChangedEventArgsBase::PropertyChangedEventArgsBase(const char* propertyName)
: RetainableObject()
, propertyName(propertyName)
{
}

PropertyChangedEventArgsBase::~PropertyChangedEventArgsBase()
{
}

const char* PropertyChangedEventArgsBase::getPropertyName()
{
    return this->propertyName.c_str();
}
