//
//  Block.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#ifndef __BreakBlocks__Block__
#define __BreakBlocks__Block__

#include "FieldObjectBase.h"

class Block : public FieldObjectBase
{
private:
    static int count;
    
    int _id;
    int durability;
    
public:
    Block();
    virtual ~Block();
    
    int getId();
    
    int getDurability();
    void setDurability(int durability);
};

#endif /* defined(__BreakBlocks__Block__) */
