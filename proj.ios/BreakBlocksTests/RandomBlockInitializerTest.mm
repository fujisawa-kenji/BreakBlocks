//
//  RandomBlockInitializerTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/10.
//
//

#import "RandomBlockInitializerTest.h"
#import "RandomBlockInitializer.h"
#import "IBlockInitializer.h"

@implementation RandomBlockInitializerTest

- (void)testCreateBall
{
    BreakBlocksPresenterMock mock;
    RandomBlockInitializer initializer(&mock);
    auto ball = initializer.createBall();
    
    auto field = mock.getGameField();
    auto x = field->getX();
    auto y = field->getY();
    auto w = field->getWidth();
    auto cx = x + w * 0.5f;
    auto cy = y + BALL_SIZE * 0.5f + BAR_HEIGHT + BAR_MARGIN;
    
    STAssertEquals(BALL_SIZE, ball->getWidth(), @"ball.width expected %f, but was %f", BALL_SIZE, ball->getWidth());
    STAssertEquals(BALL_SIZE, ball->getHeight(), @"ball.height expected %f, but was %f", BALL_SIZE, ball->getHeight());
    STAssertEquals(cx, ball->getCenterX(), @"ball.centerX expected %f, but was %f", cx, ball->getCenterX());
    STAssertEquals(cy, ball->getCenterY(), @"ball.centerY expected %f, but was %f", cy, ball->getCenterY());
    
    delete ball;
}

- (void)testCreateBar
{
    BreakBlocksPresenterMock mock;
    RandomBlockInitializer initializer(&mock);
    auto bar = initializer.createBar();
    
    auto field = mock.getGameField();
    auto x = field->getX();
    auto y = field->getY();
    auto w = field->getWidth();
    auto cx = x + w * 0.5f;
    auto cy = y + BAR_HEIGHT * 0.5f + BAR_MARGIN;
    
    STAssertEquals(BAR_WIDTH, bar->getWidth(), @"bar.width expected %f, but was %f", BAR_WIDTH, bar->getWidth());
    STAssertEquals(BAR_HEIGHT, bar->getHeight(), @"bar.height expected %f, but was %f", BAR_HEIGHT, bar->getHeight());
    STAssertEquals(cx, bar->getCenterX(), @"bar.centerX expected %f, but was %f", cx, bar->getCenterX());
    STAssertEquals(cy, bar->getCenterY(), @"bar.centerY expected %f, but was %f", cy, bar->getCenterY());
    
    delete bar;
}

- (void)testInitialBlockCount
{
    BreakBlocksPresenterMock mock;
    RandomBlockInitializer initializer(&mock);
    STAssertEquals(BLOCK_COUNT, initializer.getInitialBlockCount(), @"initialBlockCount expected %d, but was %d", BLOCK_COUNT, initializer.getInitialBlockCount());
}

- (void)testCreateBlock
{
    BreakBlocksPresenterMock mock;
    RandomBlockInitializer initializer(&mock);
    auto block = initializer.createBlock();

    auto field = mock.getGameField();
    STAssertTrue(block->insideOf(field), @"block (%f, %f) is out of field", block->getCenterX(), block->getCenterY());
    
    for (int i = 0; i < mock.getBlockCount(); i++)
    {
        auto b = mock.getBlock(i);
        STAssertFalse(block->intersectsWith(b), @"block (%f, %f) intersects with block (%f, %f)", block->getCenterX(), block->getCenterY(), b->getCenterX(), b->getCenterY());
        STAssertEquals(1, block->getDurability(), @"durability expected %d, but was %d", 1, block->getDurability());
    }
    
    delete block;
}

@end

BreakBlocksPresenterMock::BreakBlocksPresenterMock()
{
    this->field = new Field();
    this->field->setX(10.0f);
    this->field->setY(50.0f);
    this->field->setWidth(300.0f);
    this->field->setHeight(500.0f);
    
    auto block1 = new Block();
    block1->setCenterX(50.0f);
    block1->setCenterX(50.0f);
    block1->setWidth(50.0f);
    block1->setHeight(30.0f);
    this->blocks.push_back(block1);
    
    auto block2 = new Block();
    block2->setCenterX(100.0f);
    block2->setCenterX(100.0f);
    block2->setWidth(50.0f);
    block2->setHeight(30.0f);
    this->blocks.push_back(block2);
    
    auto block3 = new Block();
    block3->setCenterX(150.0f);
    block3->setCenterX(150.0f);
    block3->setWidth(50.0f);
    block3->setHeight(30.0f);
    this->blocks.push_back(block3);
}

BreakBlocksPresenterMock::~BreakBlocksPresenterMock()
{
    if (this->field != NULL)
        delete this->field;
    for (auto it = this->blocks.begin(); it != this->blocks.end(); it++)
        delete *it;
}

Field* BreakBlocksPresenterMock::getGameField()
{
    return this->field;
}

Ball* BreakBlocksPresenterMock::getBall()
{
    return NULL;
}

Bar* BreakBlocksPresenterMock::getBar()
{
    return NULL;
}

int BreakBlocksPresenterMock::getBlockCount()
{
    return this->blocks.size();
}

Block* BreakBlocksPresenterMock::getBlock(int index)
{
    return this->blocks[index];
}

IBlockInitializer* BreakBlocksPresenterMock::getInitializer()
{
    return NULL;
}

void BreakBlocksPresenterMock::setInitializer(IBlockInitializer *initializer)
{
}

void BreakBlocksPresenterMock::initialize(float x, float y, float width, float height)
{
}

GameStates BreakBlocksPresenterMock::getStatus()
{
    return Running;
}

bool BreakBlocksPresenterMock::intersectsWithBlocks(FieldObjectBase* obj)
{
    for (auto it = this->blocks.begin(); it != this->blocks.end(); it++)
    {
        if (obj->intersectsWith(*it))
            return true;
    }
    
    return false;
}

void BreakBlocksPresenterMock::updateStates()
{
}

void BreakBlocksPresenterMock::startGame()
{
}

void BreakBlocksPresenterMock::moveBar(float x, float y)
{
}
