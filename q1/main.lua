-- NOTE(Gabriel): Assuming the 1000 used here is a memory address, let's make it an argument!
local function releaseStorage(player, address)
  player:setStorageValue(address, -1)   
end

function onLogout(player)
   -- NOTE(Gabriel): To be honest, I hate hard-coded values. I tend to label them.
  local address = 1000
  
  if player:getStorageValue(address) == 1 then
     -- NOTE(Gabriel): I'm assuming the second parameter is time.
     -- NOTE(Gabriel): Yes, I found the function definition online and I was right, yay!
    local timeout = 1000

    addEvent(releaseStorage, timeout, player, address)
  end

  -- NOTE(Gabriel): I was thinking to remove the return at first, but that may make things not work anymore (maybe another function depends on this return)
  return true
end
