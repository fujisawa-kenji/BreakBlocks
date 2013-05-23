//
//  BreakBlocksPresenterTest.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "IBlockInitializer.h"

@interface BreakBlocksPresenterTest : SenTestCase

@end

class BlockInitializerMock : public IBlockInitializer
{
public:
    Ball* ball;
    Bar* bar;
    Block* block;
    
    virtual Ball* createBall();
    virtual Bar* createBar();
    
    virtual int getInitialBlockCount();
    virtual Block* createBlock();
};
