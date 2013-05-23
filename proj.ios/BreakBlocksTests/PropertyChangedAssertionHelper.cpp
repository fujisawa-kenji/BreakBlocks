//
//  PropertyChangedAssertionHelper.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#include "PropertyChangedAssertionHelper.h"

PropertyChangedListenerMock::PropertyChangedListenerMock()
{
    this->called = false;
}

PropertyChangedListenerMock::~PropertyChangedListenerMock()
{
    if (this->e != NULL)
        this->e->release();
}

void PropertyChangedListenerMock::propertyChanged(void *sender, PropertyChangedEventArgsBase *e)
{
    this->called = true;
    this->sender = sender;
    this->e = e;
    this->e->retain();
}
