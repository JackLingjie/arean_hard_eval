In PHP 8.2, you can manage the maximum number of running coroutines using the following approaches:

### 1. **Using the `maxAsyncRequests` Setting**

You can adjust the `maxAsyncRequests` setting in your PHP configuration to limit the maximum number of concurrent coroutines.

- **Method**: Update your PHP configuration file (`php.ini`).
- **Example**:
  ```php
  max_async_requests = 5
  ```

### 2. **Using the `Swoole` Extension**

If you're using the Swoole extension for coroutines, you can set the `max_coroutine` option.

- **Method**: Update your Swoole configuration.
- **Example**:
  ```php
  $config = [
      'max_coroutine' => 5,
  ];
  ```

### 3. **Using a Custom Implementation**

You can implement a custom solution using a semaphore or a queue to manage the number of running coroutines.

- **Method**: Create a custom class to manage coroutines.
- **Example**:
  ```php
  class CoroutineManager {
      private $maxCoroutines;
      private $semaphore;

      public function __construct(int $maxCoroutines) {
          $this->maxCoroutines = $maxCoroutines;
          $this->semaphore = sem_open("/coroutine_semaphore", O_CREAT, 0644, $maxCoroutines);
      }

      public function runCoroutine(callable $callback) {
          sem_acquire($this->semaphore);
          try {
              $callback();
          } finally {
              sem_release($this->semaphore);
          }
      }
  }

  $manager = new CoroutineManager(5);
  $manager->runCoroutine(function () {
      // Your coroutine code here
  });
  ```

### 4. **Using a Library**

Consider using a library like `react` or `swoole` that provides built-in support for coroutine management.

- **Method**: Install the library using Composer.
- **Example**:
  ```bash
  composer require react/promise
  ```

### Example Use Case

```php
$manager = new CoroutineManager(5);

$manager->runCoroutine(function () {
    // Your coroutine code here
});

$manager->runCoroutine(function () {
    // Your coroutine code here
});

// Attempting to run more than 5 coroutines will block until one finishes
$manager->runCoroutine(function () {
    // Your coroutine code here
});
```

By implementing one of these approaches, you can effectively manage the maximum number of running coroutines in your PHP application.