<|User Prompt|>
Write me a Java Script code that illustrates how to use a strategy pattern. Adapt it to a fun case of banking app system

<|The Start of Assistant A's Answer|>
In this example, we'll create a simple banking app system that allows users to perform different transactions using the strategy pattern. We'll have three types of transactions: deposit, withdraw, and transfer.

```javascript
// Define the strategy interface
class TransactionStrategy {
  execute(amount, account) {
    throw new Error("execute method must be implemented");
  }
}

// Concrete strategy: Deposit
class DepositStrategy extends TransactionStrategy {
  execute(amount, account) {
    account.balance += amount;
    console.log(`Deposited ${amount} to account ${account.id}. New balance: ${account.balance}`);
  }
}

// Concrete strategy: Withdraw
class WithdrawStrategy extends TransactionStrategy {
  execute(amount, account) {
    if (account.balance >= amount) {
      account.balance -= amount;
      console.log(`Withdrew ${amount} from account ${account.id}. New balance: ${account.balance}`);
    } else {
      console.log(`Insufficient balance in account ${account.id}.`);
    }
  }
}

// Concrete strategy: Transfer
class TransferStrategy extends TransactionStrategy {
  execute(amount, fromAccount, toAccount) {
    if (fromAccount.balance >= amount) {
      fromAccount.balance -= amount;
      toAccount.balance += amount;
      console.log(`Transferred ${amount} from account ${fromAccount.id} to account ${toAccount.id}.`);
    } else {
      console.log(`Insufficient balance in account ${fromAccount.id}.`);
    }
  }
}

// Context class: BankAccount
class BankAccount {
  constructor(id, balance) {
    this.id = id;
    this.balance = balance;
    this.transactionStrategy = null;
  }

  setTransactionStrategy(strategy) {
    this.transactionStrategy = strategy;
  }

  performTransaction(amount, otherAccount) {
    if (this.transactionStrategy) {
      this.transactionStrategy.execute(amount, this, otherAccount);
    } else {
      console.log("No transaction strategy set.");
    }
  }
}

// Usage
const account1 = new BankAccount(1, 1000);
const account2 = new BankAccount(2, 500);

account1.setTransactionStrategy(new DepositStrategy());
account1.performTransaction(200); // Deposited 200 to account 1. New balance: 1200

account1.setTransactionStrategy(new WithdrawStrategy());
account1.performTransaction(300); // Withdrew 300 from account 1. New balance: 900

account1.setTransactionStrategy(new TransferStrategy());
account1.performTransaction(400, account2); // Transferred 400 from account 1 to account 2.
```

In this example, we have a `BankAccount` class that represents the context. The `TransactionStrategy` interface defines the strategy, and we have three concrete strategies: `DepositStrategy`, `WithdrawStrategy`, and `TransferStrategy`. The `BankAccount` class has a `performTransaction` method that uses the current transaction strategy to execute the transaction.
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
**Strategy Pattern in a Banking App System**

The Strategy pattern allows you to define a family of algorithms, encapsulate each one as a separate class, and make them interchangeable at runtime.

### **Banking App System Overview**

In this example, we'll create a banking app system that allows users to perform transactions. We'll use the Strategy pattern to define different payment strategies.

### **Payment Strategy Interface**

```javascript
// payment-strategy.js

/**
 * Payment strategy interface.
 */
class PaymentStrategy {
  /**
   * Process payment.
   * @param {number} amount - Transaction amount.
   */
  processPayment(amount) {}
}

export default PaymentStrategy;
```

### **Concrete Payment Strategies**

We'll create concrete payment strategies for different payment methods:

#### **Credit Card Payment Strategy**

```javascript
// credit-card-payment-strategy.js

import PaymentStrategy from './payment-strategy.js';

/**
 * Credit card payment strategy.
 */
class CreditCardPaymentStrategy extends PaymentStrategy {
  /**
   * Process payment using a credit card.
   * @param {number} amount - Transaction amount.
   */
  processPayment(amount) {
    console.log(`Charging $${amount} to your credit card.`);
  }
}

export default CreditCardPaymentStrategy;
```

#### **Bank Transfer Payment Strategy**

```javascript
// bank-transfer-payment-strategy.js

import PaymentStrategy from './payment-strategy.js';

/**
 * Bank transfer payment strategy.
 */
class BankTransferPaymentStrategy extends PaymentStrategy {
  /**
   * Process payment via bank transfer.
   * @param {number} amount - Transaction amount.
   */
  processPayment(amount) {
    console.log(`Transferring $${amount} from your account.`);
  }
}

export default BankTransferPaymentStrategy;
```

### **Banking App Class**

```javascript
// banking-app.js

import PaymentStrategy from './payment-strategy.js';
import CreditCardPaymentStrategy from './credit-card-payment-strategy.js';
import BankTransferPaymentStrategy from './bank-transfer-payment-strategy.js';

/**
 * Banking app class.
 */
class BankingApp {
  /**
   * Constructor.
   * @param {PaymentStrategy} paymentStrategy - Payment strategy.
   */
  constructor(paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
  }

  /**
   * Perform a transaction.
   * @param {number} amount - Transaction amount.
   */
  performTransaction(amount) {
    this.paymentStrategy.processPayment(amount);
  }
}

// Example usage:
const creditCardStrategy = new CreditCardPaymentStrategy();
const bankingApp = new BankingApp(creditCardStrategy);
bankingApp.performTransaction(100); // Output: Charging $100 to your credit card.

const bankTransferStrategy = new BankTransferPaymentStrategy();
const bankingApp2 = new BankingApp(bankTransferStrategy);
bankingApp2.performTransaction(200); // Output: Transferring $200 from your account.
```

### **Key Takeaways**

-   The Strategy pattern allows you to define a family of algorithms and make them interchangeable at runtime.
-   Concrete payment strategies (`CreditCardPaymentStrategy` and `BankTransferPaymentStrategy`) implement the `PaymentStrategy` interface.
-   The `BankingApp` class uses a payment strategy to perform transactions.

This example demonstrates how the Strategy pattern can be applied to a banking app system, making it more flexible and maintainable.
<|The End of Assistant B's Answer|>