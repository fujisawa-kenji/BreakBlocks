//
//  IBlockInitializer.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/10.
//
//

#ifndef __BreakBlocks__IBlockInitializer__
#define __BreakBlocks__IBlockInitializer__

#include "Ball.h"
#include "Bar.h"
#include "Block.h"

class IBlockInitializer
{
public:
    virtual ~IBlockInitializer() = 0;
    
    virtual Ball* createBall() = 0;
    virtual Bar* createBar() = 0;
    
    virtual int getInitialBlockCount() = 0;
    virtual Block* createBlock() = 0;
};

#endif /* defined(__BreakBlocks__IBlockInitializer__) */
