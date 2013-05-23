//
//  Ball.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#ifndef __BreakBlocks__Ball__
#define __BreakBlocks__Ball__

#include "FieldObjectBase.h"

class Ball : public FieldObjectBase
{
private:
    float dx;
    float dy;
    
public:
    Ball();
    virtual ~Ball();
    
    float getDX();
    void setDX(float dx);
    
    float getDY();
    void setDY(float dy);
};

#endif /* defined(__BreakBlocks__Ball__) */
