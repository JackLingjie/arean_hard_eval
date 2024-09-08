Here's a SPL program that takes two numbers from the user and outputs their product:

```
ACTOR User
  ATTRIBUTE num1, num2
END

ACTOR ProductCalculator
  ATTRIBUTE product
  PROCEDURE calculateProduct(num1, num2)
    product = num1 * num2
  END
END

ACTOR Main
  ATTRIBUTE user, productCalculator
  PROCEDURE main()
    CREATE user
    CREATE productCalculator

    user.num1 = GET "Enter first number: "
    user.num2 = GET "Enter second number: "

    productCalculator.calculateProduct(user.num1, user.num2)

    PRINT "The product of " + user.num1 + " and " + user.num2 + " is " + productCalculator.product
  END
END

BEGIN
  CREATE Main
  Main.main()
END
```