//
//  RandomBlockInitializer.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/10.
//
//

#include "RandomBlockInitializer.h"

RandomBlockInitializer::RandomBlockInitializer(IBreakBlocksPresenter* presenter)
{
    this->presenter = presenter;
}

Ball* RandomBlockInitializer::createBall()
{
    auto field = this->presenter->getGameField();
    auto x = field->getX();
    auto y = field->getY();
    auto width = field->getWidth();
    
    auto ball = new Ball();
    ball->setWidth(BALL_SIZE);
    ball->setHeight(BALL_SIZE);
    ball->setCenterX(x + width * 0.5f);
    ball->setCenterY(y + BALL_SIZE * 0.5f + BAR_HEIGHT + BAR_MARGIN);
    ball->setDX(2.0f);
    ball->setDY(2.0f);
    
    return ball;
}

Bar* RandomBlockInitializer::createBar()
{
    auto field = this->presenter->getGameField();
    auto x = field->getX();
    auto y = field->getY();
    auto width = field->getWidth();
    
    auto bar = new Bar();
    bar->setWidth(BAR_WIDTH);
    bar->setHeight(BAR_HEIGHT);
    bar->setCenterX(x + width * 0.5f);
    bar->setCenterY(y + BAR_HEIGHT * 0.5f + BAR_MARGIN);
    
    return bar;
}

int RandomBlockInitializer::getInitialBlockCount()
{
    return BLOCK_COUNT;
}

Block* RandomBlockInitializer::createBlock()
{
    srand((unsigned int)time(NULL));
    
    auto field = this->presenter->getGameField();
    auto x = field->getX();
    auto y = field->getY();
    auto width = field->getWidth();
    auto height = field->getHeight();
    
    Block* block = NULL;
    while (block == NULL)
    {
        auto b = new Block();
        auto cx = rand() % (int)width + x + BLOCK_WIDTH * 0.5f;
        auto cy = rand() % (int)height + y + BLOCK_HEIGHT * 0.5f;
        b->setCenterX(cx);
        b->setCenterY(cy);
        b->setWidth(BLOCK_WIDTH);
        b->setHeight(BLOCK_HEIGHT);
        b->setDurability(1);
        
        if (b->insideOf(field) && !presenter->intersectsWithBlocks(b))
            block = b;
        else
            delete b;
    }
    
    return block;
}
