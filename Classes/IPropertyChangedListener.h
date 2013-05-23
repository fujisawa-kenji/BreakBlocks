//
//  IPropertyChangedListener.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/03.
//
//

#ifndef BreakBlocks_IPropertyChangedListener_h
#define BreakBlocks_IPropertyChangedListener_h

#include "PropertyChangedEventArgsBase.h"

class IPropertyChangedListener
{
public:
    virtual ~IPropertyChangedListener() = 0;
    
    virtual void propertyChanged(void* sender, PropertyChangedEventArgsBase* e) = 0;
};

#endif
