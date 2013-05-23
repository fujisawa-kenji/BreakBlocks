//
//  RandomBlockInitializer.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/10.
//
//

#ifndef __BreakBlocks__RandomBlockInitializer__
#define __BreakBlocks__RandomBlockInitializer__

#include "IBlockInitializer.h"
#include "IBreakBlocksPresenter.h"

#define BALL_SIZE 10.0f

#define BAR_WIDTH 50.0f
#define BAR_HEIGHT 20.0f
#define BAR_MARGIN 20.0f

#define BLOCK_COUNT 20
#define BLOCK_WIDTH 50.0f
#define BLOCK_HEIGHT 20.0f

class RandomBlockInitializer : public IBlockInitializer
{
private:
    IBreakBlocksPresenter* presenter;
    
public:
    RandomBlockInitializer(IBreakBlocksPresenter* presenter);
    
    virtual Ball* createBall();
    virtual Bar* createBar();
    
    virtual int getInitialBlockCount();
    virtual Block* createBlock();
};

#endif /* defined(__BreakBlocks__RandomBlockInitializer__) */
