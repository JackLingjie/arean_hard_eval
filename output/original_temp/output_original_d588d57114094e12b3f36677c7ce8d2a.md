You want to achieve a default export in JavaScript that allows you to call multiple functions directly on the default export.

This is possible using a technique called **namespace objects** or **module augmentation**.

Here are a few ways to achieve this:

### 1. Using an Object

You can create an object with your functions and export it as the default export.

```javascript
// util.js
export default {
  doSomething() {
    console.log('Doing something');
  },
  doSomethingElse() {
    console.log('Doing something else');
  },
};
```

Then, in another file:

```javascript
// main.js
import Util from './util.js';

Util.doSomething(); // Outputs: Doing something
Util.doSomethingElse(); // Outputs: Doing something else
```

### 2. Using a Class

If you prefer a more object-oriented approach, you can use a class.

```javascript
// util.js
class Util {
  doSomething() {
    console.log('Doing something');
  }

  doSomethingElse() {
    console.log('Doing something else');
  }
}

export default new Util();
```

Then, in another file:

```javascript
// main.js
import Util from './util.js';

Util.doSomething(); // Outputs: Doing something
Util.doSomethingElse(); // Outputs: Doing something else
```

### 3. Using a Function

If you prefer a more functional approach, you can use a function.

```javascript
// util.js
const Util = () => ({
  doSomething() {
    console.log('Doing something');
  },
  doSomethingElse() {
    console.log('Doing something else');
  },
});

export default Util();
```

Then, in another file:

```javascript
// main.js
import Util from './util.js';

Util().doSomething(); // Outputs: Doing something
Util().doSomethingElse(); // Outputs: Doing something else
```

Each of these methods allows you to call multiple functions directly on the default export. Choose the one that best fits your needs.