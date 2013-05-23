//
//  RetainableObject.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/12.
//
//

#include "RetainableObject.h"

RetainableObject::RetainableObject()
: referenceCount(0)
{
}

RetainableObject::~RetainableObject()
{
}

void RetainableObject::retain()
{
    this->referenceCount++;
}

void RetainableObject::release()
{
    this->referenceCount--;
    
    if (this->referenceCount <= 0)
        delete this;
}

int RetainableObject::getReferenceCount()
{
    return this->referenceCount;
}
