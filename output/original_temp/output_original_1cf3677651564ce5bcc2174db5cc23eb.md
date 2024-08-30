**HMAC (Keyed-Hash Message Authentication Code) Overview**

### Key Components

- **Input Parameters**: HMAC requires two primary inputs:
  - **Secret Key (K)**: The key used for authentication.
  - **Message or Data (M)**: The data to be authenticated.
  - **Cryptographic Hash Function (H)**: A hash function like SHA-256 or SHA-3.

### Key Padding

- **Padding or Truncation**: The secret key (K) is padded or truncated to match the block size of the hash function (typically 512 bits for SHA-2).

### Inner Padding

- **XOR Operations**: The padded key (K) is XORed with two fixed values:
  - **Inner Padding Constant (ipad)**: Used before hashing.
  - **Outer Padding Constant (opad)**: Used after hashing.

### Hash Operations

- **Inner Hash**: The inner padding (ipad XOR K) is concatenated with the message (M). This combined value is hashed using the chosen hash function (H), producing an intermediate hash result.
- **Outer Hash**: The outer padding (opad XOR K) is concatenated with the intermediate hash result. This combined value is hashed again using the same hash function (H), yielding the HMAC.

### HMAC Output

- **Final HMAC**: The output of the second hash operation is the HMAC, a fixed-size value that can be appended to the message to create a MAC.