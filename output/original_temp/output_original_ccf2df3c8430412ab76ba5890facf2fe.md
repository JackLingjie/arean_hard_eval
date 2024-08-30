**Mining a Block on a Proof of Authority (PoA) Ethereum Chain**

To mine a block on a Proof of Authority (PoA) Ethereum chain, you'll need to interact with the Ethereum JSON-RPC API. This example uses the `web3.py` library to connect to the node.

### Prerequisites

- **Ethereum Node**: Ensure you have a PoA Ethereum node running at `10.0.35.11`.
- **Python Environment**: Set up a Python environment with the necessary libraries.

### Step 1: Install Required Libraries

```bash
pip install web3
```

### Step 2: Connect to the Ethereum Node

```python
from web3 import Web3

# Define the Ethereum node's URL
node_url = "http://10.0.35.11:8545"

# Create a Web3 instance
w3 = Web3(Web3.HTTPProvider(node_url))
```

### Step 3: Mine a Block

```python
# Mine a block
w3.eth.mining(True)  # Enable mining
w3.eth.mining(False)  # Disable mining after mining a block
```

### Step 4: Verify the Block

```python
# Get the block number
block_number = w3.eth.blockNumber

# Get the mined block
block = w3.eth.getBlock(block_number)

# Print the block details
print("Mined Block:")
print(f"Number: {block.number}")
print(f"Hash: {block.hash}")
print(f"Timestamp: {block.timestamp}")
```

### Full Code Example

```python
from web3 import Web3

def mine_block():
    # Define the Ethereum node's URL
    node_url = "http://10.0.35.11:8545"

    # Create a Web3 instance
    w3 = Web3(Web3.HTTPProvider(node_url))

    # Mine a block
    w3.eth.mining(True)  # Enable mining
    w3.eth.mining(False)  # Disable mining after mining a block

    # Get the block number
    block_number = w3.eth.blockNumber

    # Get the mined block
    block = w3.eth.getBlock(block_number)

    # Print the block details
    print("Mined Block:")
    print(f"Number: {block.number}")
    print(f"Hash: {block.hash}")
    print(f"Timestamp: {block.timestamp}")

# Execute the function
mine_block()
```

This code connects to the Ethereum node at `10.0.35.11`, enables mining, mines a block, disables mining, and prints the details of the mined block.