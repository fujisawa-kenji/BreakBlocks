//
//  BreakBlocksPresenter.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#include "BreakBlocksPresenter.h"
#include "RandomBlockInitializer.h"

BreakBlocksPresenter::BreakBlocksPresenter()
: field(NULL)
, ball(NULL)
, bar(NULL)
, initializer(new RandomBlockInitializer(this))
{
}

BreakBlocksPresenter::~BreakBlocksPresenter()
{
    if (this->field != NULL)
        delete this->field;
    if (this->ball != NULL)
        delete this->ball;
    if (this->bar != NULL)
        delete this->bar;
    for (auto it = this->blocks.begin(); it != this->blocks.end(); it++)
        delete *it;
    if (this->initializer != NULL)
        delete this->initializer;
}

Field* BreakBlocksPresenter::getGameField()
{
    return this->field;
}

Ball* BreakBlocksPresenter::getBall()
{
    return this->ball;
}

Bar* BreakBlocksPresenter::getBar()
{
    return this->bar;
}

int BreakBlocksPresenter::getBlockCount()
{
    return this->blocks.size();
}

Block* BreakBlocksPresenter::getBlock(int index)
{
    auto count = this->blocks.size();
    if (0 <= index && index <= count - 1)
        return this->blocks[index];
    else
        return NULL;
}

IBlockInitializer* BreakBlocksPresenter::getInitializer()
{
    return this->initializer;
}

void BreakBlocksPresenter::setInitializer(IBlockInitializer *initializer)
{
    this->initializer = initializer;
}

void BreakBlocksPresenter::initialize(float x, float y, float width, float height)
{
    this->field = new Field();
    this->field->setX(x);
    this->field->setY(y);
    this->field->setWidth(width);
    this->field->setHeight(height);
    
    this->ball = this->initializer->createBall();
    
    this->bar = this->initializer->createBar();
    
    for (int i = 0; i < this->initializer->getInitialBlockCount(); i++)
        this->blocks.push_back(initializer->createBlock());
    
    this->status = Ready;
}

GameStates BreakBlocksPresenter::getStatus()
{
    return this->status;
}

bool BreakBlocksPresenter::intersectsWithBlocks(FieldObjectBase *obj)
{
    return this->getIntersectsWith(obj) != NULL;
}

Block* BreakBlocksPresenter::getIntersectsWith(FieldObjectBase *obj)
{
    if (obj == NULL)
        return NULL;
    
    for (auto it = this->blocks.begin(); it != this->blocks.end(); it++)
    {
        if (*it != NULL && (*it)->getDurability() > 0 && obj != *it && obj->intersectsWith(*it))
            return *it;
    }
    
    return NULL;
}

void BreakBlocksPresenter::updateStates()
{
    if (this->status != Running)
        return;
    
    this->updateBallPosition();
    this->updateBounds();
    
    bool clear = true;
    for (auto it = this->blocks.begin(); it != this->blocks.end(); it++)
    {
        if (*it != NULL && (*it)->getDurability() > 0)
            clear = false;
    }
    if (clear)
        this->status = Clear;
}

void BreakBlocksPresenter::updateBallPosition()
{
    auto x = this->ball->getCenterX() + this->ball->getDX();
    auto y = this->ball->getCenterY() + this->ball->getDY();
    this->ball->setCenterX(x);
    this->ball->setCenterY(y);
}

void BreakBlocksPresenter::updateBounds()
{
    auto ball = this->ball;
    auto field = this->field;
    if (!ball->insideOf(field))
    {
        this->updateBoundsField();
    }
    else
    {
        this->updateBoundsBar();
        this->updateBoundsBlocks();
    }
}

void BreakBlocksPresenter::updateBoundsField()
{
    if (ball->getCenterX() - ball->getWidth() <= field->getX() ||
        ball->getCenterX() + ball->getWidth() >= field->getX() + field->getWidth())
    {
        ball->setDX(ball->getDX() * -1);
    }
    if (ball->getCenterY() + ball->getHeight() >= field->getY() + field->getHeight())
    {
        ball->setDY(ball->getDY() * -1);
    }
    if (ball->getCenterY() < field->getY())
    {
        this->status = GameOver;
    }
}

void BreakBlocksPresenter::updateBoundsBar()
{
    auto ball = this->ball;
    auto bar = this->bar;
    if (!ball->intersectsWith(bar))
        return;
    
    auto x11 = ball->getCenterX() - ball->getWidth() * 0.5f;
    auto x12 = ball->getCenterX() + ball->getWidth() * 0.5f;
    auto y11 = ball->getCenterY() - ball->getHeight() * 0.5f;
    auto y12 = ball->getCenterY() + ball->getHeight() * 0.5f;
    
    auto x21 = bar->getCenterX() - bar->getWidth() * 0.5f;
    auto x22 = bar->getCenterX() + bar->getWidth() * 0.5f;
    auto y21 = bar->getCenterY() - bar->getHeight() * 0.5f;
    auto y22 = bar->getCenterY() + bar->getHeight() * 0.5f;
    
    if (x21 < x11 && x12 < x22)
        ball->setDY(ball->getDY() * -1);
    else if (y21 < y11 && y12 < y22)
        ball->setDX(ball->getDY() * -1);
    else
    {
        ball->setDX(ball->getDX() * -1);
        ball->setDY(ball->getDY() * -1);
    }
}

void BreakBlocksPresenter::updateBoundsBlocks()
{
    auto ball = this->ball;
    auto block = this->getIntersectsWith(ball);
    if (block == NULL)
        return;
    
    auto x11 = ball->getCenterX() - ball->getWidth() * 0.5f;
    auto x12 = ball->getCenterX() + ball->getWidth() * 0.5f;
    auto y11 = ball->getCenterY() - ball->getHeight() * 0.5f;
    auto y12 = ball->getCenterY() + ball->getHeight() * 0.5f;
    
    auto x21 = block->getCenterX() - block->getWidth() * 0.5f;
    auto x22 = block->getCenterX() + block->getWidth() * 0.5f;
    auto y21 = block->getCenterY() - block->getHeight() * 0.5f;
    auto y22 = block->getCenterY() + block->getHeight() * 0.5f;
    
    if (x21 < x11 && x12 < x22)
        ball->setDY(ball->getDY() * -1);
    else if (y21 < y11 && y12 < y22)
        ball->setDX(ball->getDY() * -1);
    else
    {
        ball->setDX(ball->getDX() * -1);
        ball->setDY(ball->getDY() * -1);
    }
    
    block->setDurability(block->getDurability() - 1);
}

void BreakBlocksPresenter::startGame()
{
    this->status = Running;
}

void BreakBlocksPresenter::moveBar(float x, float y)
{
    auto field = this->field;
    auto bar = this->bar;
    
    if (x - bar->getWidth() * 0.5f < field->getX())
        x = bar->getWidth() * 0.5f;
    if (x + bar->getWidth() * 0.5f > field->getX() + field->getWidth())
        x = field->getX() + field->getWidth() - bar->getWidth() * 0.5f;
    
    bar->setCenterX(x);
}
