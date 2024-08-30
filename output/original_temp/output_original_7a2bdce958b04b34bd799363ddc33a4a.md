**IP Whitelisting Middleware in Laravel**

To block users whose IP is not in the allowed list, you can create a middleware in Laravel. Here's a step-by-step guide:

### Step 1: Create the Middleware

Create a new middleware by running the following command:

```bash
php artisan make:middleware IpWhitelist
```

### Step 2: Define the Middleware

In the `IpWhitelist.php` file, add the following code:

```php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class IpWhitelist
{
    /**
     * The list of allowed IP addresses.
     *
     * @var array
     */
    private $allowedIps = [
        '192.168.1.100', // Example IP
        '192.168.1.200', // Another example IP
    ];

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        if (!in_array($request->ip(), $this->allowedIps)) {
            // Return a response to block the request
            return response('Your IP is not allowed.', 403);
        }

        // Continue to the next middleware or route
        return $next($request);
    }
}
```

### Step 3: Register the Middleware

In the `kernel.php` file (located in the `app/Http` directory), add the middleware to the `middleware` group:

```php
protected $middleware = [
    // ...
    \App\Http\Middleware\IpWhitelist::class,
];
```

### Step 4: Apply the Middleware

To apply the middleware to specific routes or controllers, use the `middleware` method:

```php
Route::get('/protected', function () {
    // This route is protected by the IpWhitelist middleware
})->middleware('ipWhitelist');
```

Alternatively, you can apply the middleware to all routes by adding it to the `middleware` group:

```php
protected $middleware = [
    // ...
    \App\Http\Middleware\IpWhitelist::class,
];
```

### Example Use Case

Suppose you want to restrict access to a specific route:

```php
Route::get('/admin', function () {
    // This route is protected by the IpWhitelist middleware
})->middleware('ipWhitelist');
```

In this example, only users with IP addresses in the `allowedIps` array can access the `/admin` route.

### Notes

- This middleware uses the `ip()` method to get the client's IP address.
- You can modify the `allowedIps` array to include or exclude specific IP addresses.
- This is a basic implementation. You may want to consider using a more robust IP validation method, such as checking against a database or a third-party service.