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