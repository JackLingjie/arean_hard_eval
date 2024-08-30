**Secure XPath Expression**

To prevent XPath injection vulnerabilities, use a parameterized approach. This ensures that user input is treated as data, not code.

### Original Vulnerable Code

```java
String expression = "/users/user[@name='" + user + "' and @pass='" + pass + "']";
```

### Secure Parameterized Code

```java
String expression = "/users/user[@name='" + user + "' and @pass='" + pass + "']";
```

**Improved Version**

```java
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathFactory;

// ...

// Create an XPath instance
XPath xPath = XPathFactory.newInstance().newXPath();

// Use a parameterized XPath expression
String expression = "/users/user[@name=$name and @pass=$pass]";

// Set the parameters
Map<String, String> params = new HashMap<>();
params.put("name", user);
params.put("pass", pass);

// Evaluate the XPath expression
try {
    NodeList nodeList = (NodeList) xPath.evaluate(expression, xmlDocument, XPathConstants.NODESET, null, params);
    // Process the result
} catch (XPathExpressionException e) {
    // Handle the exception
}
```

**Key Changes:**

- **Parameterized XPath**: Use placeholders (`$name` and `$pass`) in the XPath expression.
- **Parameter Mapping**: Map user input to these placeholders using a `Map`.
- **Secure Evaluation**: Use the `evaluate` method with the parameter map to prevent injection.

By following this approach, you ensure that user input is treated as data, not code, thereby preventing XPath injection vulnerabilities.