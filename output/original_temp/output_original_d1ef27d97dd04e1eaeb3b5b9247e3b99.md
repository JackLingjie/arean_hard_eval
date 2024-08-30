**Implementing TCP in TypeScript**

Below is a simplified implementation of the TCP protocol in TypeScript. This example focuses on the key aspects of TCP, including:

- **Segment Structure**: TCP segments are composed of a header and data.
- **Header Fields**:
  - **Source Port** and **Destination Port**: Identifies the ports for the source and destination.
  - **Sequence Number** and **Acknowledgment Number**: Used for reliable data transfer.
  - **Data Offset**: Indicates the size of the TCP header.
  - **Flags**: Control the behavior of the connection.
  - **Window Size**: The amount of data the sender can send before receiving an acknowledgment.
  - **Checksum**: Ensures data integrity.
  - **Urgent Pointer**: Used for urgent data.

### TCP Segment Structure

```typescript
interface TcpSegment {
  sourcePort: number;
  destinationPort: number;
  sequenceNumber: number;
  acknowledgmentNumber: number;
  dataOffset: number;
  reserved: number;
  flags: {
    syn: boolean;
    ack: boolean;
    fin: boolean;
    urgent: boolean;
  };
  windowSize: number;
  checksum: number;
  urgentPointer: number;
  data: Uint8Array;
}
```

### TCP Header

```typescript
class TcpHeader {
  private sourcePort: number;
  private destinationPort: number;
  private sequenceNumber: number;
  private acknowledgmentNumber: number;
  private dataOffset: number;
  private reserved: number;
  private flags: {
    syn: boolean;
    ack: boolean;
    fin: boolean;
    urgent: boolean;
  };
  private windowSize: number;
  private checksum: number;
  private urgentPointer: number;

  constructor(
    sourcePort: number,
    destinationPort: number,
    sequenceNumber: number,
    acknowledgmentNumber: number,
    dataOffset: number,
    reserved: number,
    flags: {
      syn: boolean;
      ack: boolean;
      fin: boolean;
      urgent: boolean;
    },
    windowSize: number,
    checksum: number,
    urgentPointer: number
  ) {
    this.sourcePort = sourcePort;
    this.destinationPort = destinationPort;
    this.sequenceNumber = sequenceNumber;
    this.acknowledgmentNumber = acknowledgmentNumber;
    this.dataOffset = dataOffset;
    this.reserved = reserved;
    this.flags = flags;
    this.windowSize = windowSize;
    this.checksum = checksum;
    this.urgentPointer = urgentPointer;
  }

  public toBytes(): Uint8Array {
    // Convert TCP header fields to bytes
    const headerBytes = new Uint8Array(20);

    // Source Port
    headerBytes[0] = (this.sourcePort >> 8) & 0xff;
    headerBytes[1] = this.sourcePort & 0xff;

    // Destination Port
    headerBytes[2] = (this.destinationPort >> 8) & 0xff;
    headerBytes[3] = this.destinationPort & 0xff;

    // Sequence Number
    headerBytes[4] = (this.sequenceNumber >> 24) & 0xff;
    headerBytes[5] = (this.sequenceNumber >> 16) & 0xff;
    headerBytes[6] = (this.sequenceNumber >> 8) & 0xff;
    headerBytes[7] = this.sequenceNumber & 0xff;

    // Acknowledgment Number
    headerBytes[8] = (this.acknowledgmentNumber >> 24) & 0xff;
    headerBytes[9] = (this.acknowledgmentNumber >> 16) & 0xff;
    headerBytes[10] = (this.acknowledgmentNumber >> 8) & 0xff;
    headerBytes[11] = this.acknowledgmentNumber & 0xff;

    // Data Offset
    headerBytes[12] = (this.dataOffset << 4) & 0xff;

    // Reserved
    headerBytes[13] = this.reserved;

    // Flags
    const flagsByte = 0;
    if (this.flags.syn) flagsByte |= 0x02;
    if (this.flags.ack) flagsByte |= 0x10;
    if (this.flags.fin) flagsByte |= 0x01;
    if (this.flags.urgent) flagsByte |= 0x20;
    headerBytes[13] |= flagsByte;

    // Window Size
    headerBytes[14] = (this.windowSize >> 8) & 0xff;
    headerBytes[15] = this.windowSize & 0xff;

    // Checksum
    headerBytes[16] = (this.checksum >> 8) & 0xff;
    headerBytes[17] = this.checksum & 0xff;

    // Urgent Pointer
    headerBytes[18] = (this.urgentPointer >> 8) & 0xff;
    headerBytes[19] = this.urgentPointer & 0xff;

    return headerBytes;
  }
}
```

### Example Usage

```typescript
// Create a new TCP segment
const tcpSegment: TcpSegment = {
  sourcePort: 1234,
  destinationPort: 5678,
  sequenceNumber: 100,
  acknowledgmentNumber: 200,
  dataOffset: 5,
  reserved: 0,
  flags: {
    syn: true,
    ack: false,
    fin: false,
    urgent: false,
  },
  windowSize: 1024,
  checksum: 0,
  urgentPointer: 0,
  data: new Uint8Array(10), // Data payload
};

// Create a new TCP header
const tcpHeader = new TcpHeader(
  tcpSegment.sourcePort,
  tcpSegment.destinationPort,
  tcpSegment.sequenceNumber,
  tcpSegment.acknowledgmentNumber,
  tcpSegment.dataOffset,
  tcpSegment.reserved,
  tcpSegment.flags,
  tcpSegment.windowSize,
  tcpSegment.checksum,
  tcpSegment.urgentPointer
);

// Convert the TCP header to bytes
const tcpHeaderBytes = tcpHeader.toBytes();

console.log(tcpHeaderBytes);
```

This example demonstrates how to create a TCP segment and convert its header to bytes. The `TcpHeader` class encapsulates the TCP header fields and provides a method to convert them to bytes. The `TcpSegment` interface defines the structure of a TCP segment.