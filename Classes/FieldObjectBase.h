//
//  FieldObjectBase.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#ifndef __BreakBlocks__FieldObjectBase__
#define __BreakBlocks__FieldObjectBase__

#include "NotifyPropertyChangedBase.h"
#include "Field.h"

class FieldObjectBase : public NotifyPropertyChangedBase
{
private:
    float centerX;
    float centerY;
    float width;
    float height;
    
public:
    FieldObjectBase();
    virtual ~FieldObjectBase();
    
    float getCenterX();
    void setCenterX(float x);
    
    float getCenterY();
    void setCenterY(float y);
    
    float getWidth();
    void setWidth(float width);
    
    float getHeight();
    void setHeight(float height);
    
    bool intersectsWith(FieldObjectBase* obj);
    bool insideOf(Field* field);
};

#endif /* defined(__BreakBlocks__FieldObjectBase__) */
