//
//  RandomBlockInitializerTest.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/10.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import <vector>
#import "IBreakBlocksPresenter.h"

@interface RandomBlockInitializerTest : SenTestCase

@end

class BreakBlocksPresenterMock : public IBreakBlocksPresenter
{
private:
    Field* field;
    vector<Block*> blocks;
    
public:
    BreakBlocksPresenterMock();
    ~BreakBlocksPresenterMock();
    
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
