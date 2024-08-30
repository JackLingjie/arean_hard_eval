**Inventory Module for Roblox**

### Overview

This module provides a simple and efficient way to manage player inventories in Roblox. It utilizes a table to store item quantities, indexed by player name and item name.

### Code

```lua
-- Inventory Module

-- Initialize the inventory table
local inventory = {}

-- Function to add items to a player's inventory
function addItems(player, items)
    -- Check if the player already has an inventory
    if not inventory[player.Name] then
        inventory[player.Name] = {}
    end

    -- Iterate over each item
    for itemName, quantity in pairs(items) do
        -- Add the item to the player's inventory
        inventory[player.Name][itemName] = (inventory[player.Name][itemName] or 0) + quantity
    end
end

-- Function to remove items from a player's inventory
function removeItems(player, items)
    -- Check if the player has an inventory
    if inventory[player.Name] then
        -- Iterate over each item
        for itemName, quantity in pairs(items) do
            -- Subtract the item quantity from the player's inventory
            inventory[player.Name][itemName] = math.max(inventory[player.Name][itemName] - quantity, 0)
        end

        -- Remove the player's inventory if it's empty
        if next(inventory[player.Name]) == nil then
            inventory[player.Name] = nil
        end
    end
end

-- Function to get a player's inventory
function getPlayerInventory(player)
    return inventory[player.Name]
end

-- Function to check if a player has an item
function hasItem(player, itemName)
    return inventory[player.Name] and inventory[player.Name][itemName] > 0
end

-- Function to get the quantity of an item in a player's inventory
function getItemQuantity(player, itemName)
    return inventory[player.Name] and inventory[player.Name][itemName]
end

-- Example usage:
-- Add items to a player's inventory
local player = game.Players.LocalPlayer
addItems(player, { "Sword" = 2, "Shield" = 1 })

-- Get the player's inventory
local inventory = getPlayerInventory(player)
print(inventory["Sword"])  -- Output: 2

-- Check if the player has an item
print(hasItem(player, "Sword"))  -- Output: true

-- Remove items from the player's inventory
removeItems(player, { "Sword" = 1 })

-- Get the updated item quantity
print(getItemQuantity(player, "Sword"))  -- Output: 1
```

### Explanation

This module provides the following functions:

- `addItems(player, items)`: Adds items to a player's inventory.
- `removeItems(player, items)`: Removes items from a player's inventory.
- `getPlayerInventory(player)`: Returns a player's inventory.
- `hasItem(player, itemName)`: Checks if a player has an item.
- `getItemQuantity(player, itemName)`: Returns the quantity of an item in a player's inventory.

### Example Use Cases

- Adding items to a player's inventory:
  ```lua
  addItems(player, { "Sword" = 2, "Shield" = 1 })
  ```
- Removing items from a player's inventory:
  ```lua
  removeItems(player, { "Sword" = 1 })
  ```
- Checking if a player has an item:
  ```lua
  print(hasItem(player, "Sword"))  -- Output: true
  ```
- Getting the quantity of an item in a player's inventory:
  ```lua
  print(getItemQuantity(player, "Sword"))  -- Output: 1
  ```