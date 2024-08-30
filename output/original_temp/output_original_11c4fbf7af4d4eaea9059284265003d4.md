**Models for Badminton Restring Tracker**

Below is a suggested design for the `models.py` file in your Django project. This design includes models for customers, restrings, and payments.

### Models

```python
from django.db import models

class Customer(models.Model):
    """
    Model representing a customer.
    """
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=20)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


class Restring(models.Model):
    """
    Model representing a badminton restring.
    """
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    racket_type = models.CharField(max_length=100)
    string_type = models.CharField(max_length=100)
    date = models.DateField()
    price = models.DecimalField(max_digits=5, decimal_places=2)

    def __str__(self):
        return f"{self.customer} - {self.racket_type} restring"


class Payment(models.Model):
    """
    Model representing a payment.
    """
    restring = models.ForeignKey(Restring, on_delete=models.CASCADE)
    payment_method = models.CharField(max_length=50)  # e.g., Cash, Card, etc.
    amount = models.DecimalField(max_digits=5, decimal_places=2)
    date = models.DateField()

    def __str__(self):
        return f"Payment for {self.restring}"
```

### Explanation

- **Customer Model**:
  - `first_name` and `last_name` store the customer's name.
  - `email` is unique and must be an email address.
  - `phone_number` stores the customer's phone number.

- **Restring Model**:
  - `customer` is a foreign key referencing the `Customer` model.
  - `racket_type` and `string_type` describe the restring.
  - `date` records the date of the restring.
  - `price` stores the cost of the restring.

- **Payment Model**:
  - `restring` is a foreign key referencing the `Restring` model.
  - `payment_method` indicates how the payment was made.
  - `amount` stores the payment amount.
  - `date` records the payment date.

### Example Use Cases

- **Create a new customer**:
  ```python
customer = Customer(first_name="John", last_name="Doe", email="john@example.com", phone_number="1234567890")
customer.save()
```

- **Create a new restring**:
  ```python
restring = Restring(customer=customer, racket_type="Racket A", string_type="String B", date="2023-03-01", price=10.99)
restring.save()
```

- **Create a new payment**:
  ```python
payment = Payment(restring=restring, payment_method="Cash", amount=10.99, date="2023-03-01")
payment.save()
```

This design provides a solid foundation for managing customers, restrings, and payments in your badminton restring tracker application.