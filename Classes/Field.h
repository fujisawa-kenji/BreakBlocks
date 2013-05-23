//
//  Field.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#ifndef __BreakBlocks__Field__
#define __BreakBlocks__Field__

#include "NotifyPropertyChangedBase.h"

class Field : public NotifyPropertyChangedBase
{
private:
    float x;
    float y;
    float width;
    float height;
    
public:
    Field();
    virtual ~Field();
    
    float getX();
    void setX(float x);

    float getY();
    void setY(float y);

    float getWidth();
    void setWidth(float width);

    float getHeight();
    void setHeight(float height);
};

#endif /* defined(__BreakBlocks__Field__) */
