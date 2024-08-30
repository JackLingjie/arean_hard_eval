To extract the type of the `ReactProperties` member object from the class `Foo`, you can use the `typeof` operator in TypeScript. 

Here's how you can do it:

```typescript
class Foo {
  ReactProperties: {
    a: string;
  }
}

// Extract the type of ReactProperties
type ReactPropertiesType = Foo['ReactProperties'];

// Example usage:
const foo = new Foo();
const properties: ReactPropertiesType = foo.ReactProperties;
```

In this code:

- `Foo['ReactProperties']` is used to access the `ReactProperties` property of the `Foo` class.
- The resulting type is then aliased with the name `ReactPropertiesType`.

This approach allows you to extract the type of any property from a class or interface. 

Note: This syntax is called **indexing** and is a feature of TypeScript that allows you to access properties of types.