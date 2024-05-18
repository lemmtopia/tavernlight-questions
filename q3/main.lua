function do_sth_with_PlayerParty(playerId, membername)
   player = Player(playerId)
   local party = player:getParty()

   for _, curMember in pairs(party:getMembers()) do
      -- NOTE(Gabriel): Looking at the docs, we have a getName() function. Since we're comparing v with a Player object it migth be a player. This means that we can use getName()
      -- NOTE(lemmtopia): A day later, I figured out you can actually use the name, but it may be slower to search the player that way.
      if curMember:getName() == membername then
	 party:removeMember(curMember)
      end
   end
end
