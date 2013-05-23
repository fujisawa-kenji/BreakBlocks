//
//  PropertyChangedEventArgsBase.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/05.
//
//

#ifndef __BreakBlocks__PropertyChangedEventArgsBase__
#define __BreakBlocks__PropertyChangedEventArgsBase__

#include <string>
#include "RetainableObject.h"

using namespace std;

class PropertyChangedEventArgsBase : public RetainableObject
{
protected:
    string propertyName;
    
public:
    PropertyChangedEventArgsBase(const char* propertyName);
    virtual ~PropertyChangedEventArgsBase();
    
    const char* getPropertyName();
};

#endif /* defined(__BreakBlocks__PropertyChangedEventArgsBase__) */
