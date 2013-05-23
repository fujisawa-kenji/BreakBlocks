//
//  BreakBlocksPresenter.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#ifndef __BreakBlocks__BreakBlocksPresenter__
#define __BreakBlocks__BreakBlocksPresenter__

#include "IBreakBlocksPresenter.h"

class BreakBlocksPresenter : public IBreakBlocksPresenter
{
private:
    GameStates status;
    
    Field* field;
    Ball* ball;
    Bar* bar;
    vector<Block*> blocks;
    
    IBlockInitializer* initializer;
    
    void updateBallPosition();
    void updateBounds();
    void updateBoundsField();
    void updateBoundsBar();
    void updateBoundsBlocks();
    
    Block* getIntersectsWith(FieldObjectBase* obj);
    
public:
    BreakBlocksPresenter();
    virtual ~BreakBlocksPresenter();
    
    virtual Field* getGameField();
    virtual Ball* getBall();
    virtual Bar* getBar();
    
    virtual int getBlockCount();
    virtual Block* getBlock(int index);
    
    virtual IBlockInitializer* getInitializer();
    virtual void setInitializer(IBlockInitializer* initializer);
    virtual void initialize(float x, float y, float width, float height);
    
    virtual GameStates getStatus();
    
    virtual bool intersectsWithBlocks(FieldObjectBase* obj);
    
    virtual void updateStates();
    
    virtual void startGame();
    virtual void moveBar(float x, float y);
};

#endif /* defined(__BreakBlocks__BreakBlocksPresenter__) */
