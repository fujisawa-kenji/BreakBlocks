//
//  IBreakBlocksPresenter.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/18.
//
//

#ifndef BreakBlocks_IBreakBlocksPresenter_h
#define BreakBlocks_IBreakBlocksPresenter_h

#include "Ball.h"
#include "Field.h"
#include "IBlockInitializer.h"

enum GameStates
{
    Ready,
    Running,
    Clear,
    GameOver
};

class IBreakBlocksPresenter
{
public:
    virtual ~IBreakBlocksPresenter() = 0;
    
    virtual Field* getGameField() = 0;
    virtual Ball* getBall() = 0;
    virtual Bar* getBar() = 0;
    
    virtual int getBlockCount() = 0;
    virtual Block* getBlock(int index) = 0;
    
    virtual IBlockInitializer* getInitializer() = 0;
    virtual void setInitializer(IBlockInitializer* initializer) = 0;
    virtual void initialize(float x, float y, float width, float height) = 0;
    
    virtual GameStates getStatus() = 0;
    
    virtual bool intersectsWithBlocks(FieldObjectBase* obj) = 0;
    
    virtual void updateStates() = 0;
    
    virtual void startGame() = 0;
    virtual void moveBar(float x, float y) = 0;
};

#endif
