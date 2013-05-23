//
//  Block.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#include "Block.h"

int Block::count = 0;

Block::Block()
: _id(Block::count++)
, durability(0)
{
}

Block::~Block()
{
}

int Block::getId()
{
    return this->_id;
}

int Block::getDurability()
{
    return this->durability;
}

void Block::setDurability(int durability)
{
    if (this->durability == durability)
        return;
    
    auto oldValue = this->getDurability();
    auto newValue = durability;
    this->durability = durability;
    this->onPropertyChanged<int>("durability", oldValue, newValue);
}
