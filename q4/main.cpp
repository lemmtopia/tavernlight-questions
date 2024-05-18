void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
	player = new Player(nullptr);
	if (!IOLoginData::loadPlayerByName(player, recipient)) {
	    // NOTE(Gabriel): Aha! We need to free the memory of the player object when we aree done with it.
	    // NOTE(Gabriel): We could avoid needing to deal with memory issues by using a smart pointer, but I prefer the old-school way :)
	    delete player;
	    return;
	}
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
	// NOTE(Gabriel): Same thing here
	delete item;
	return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
	IOLoginData::savePlayer(player);
    }
}
