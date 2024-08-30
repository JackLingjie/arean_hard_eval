**Favorites Manager Class**

The `FavoritesManager` class handles adding and removing business names from a user's favorites list. It saves the list to the database for logged-in users and to the session for guests.

```php
namespace App\Favorites;

use App\Models\User;
use App\Models\Favorite;

class FavoritesManager
{
    /**
     * Add a business name to the user's favorites list.
     *
     * @param int $userId
     * @param string $name
     * @return void
     */
    public function add(int $userId, string $name): void
    {
        // Check if user is logged in or a guest
        if (Auth::check()) {
            // Save to database for logged-in users
            $this->saveToDatabase($userId, $name);
        } else {
            // Save to session for guests
            $this->saveToSession($userId, $name);
        }
    }

    /**
     * Remove a business name from the user's favorites list.
     *
     * @param int $userId
     * @param string $name
     * @return void
     */
    public function remove(int $userId, string $name): void
    {
        // Check if user is logged in or a guest
        if (Auth::check()) {
            // Remove from database for logged-in users
            $this->removeFromDatabase($userId, $name);
        } else {
            // Remove from session for guests
            $this->removeFromSession($userId, $name);
        }
    }

    /**
     * Save the favorites list to the database for logged-in users.
     *
     * @param int $userId
     * @param string $name
     * @return void
     */
    private function saveToDatabase(int $userId, string $name): void
    {
        // Create a new Favorite instance
        $favorite = new Favorite();
        $favorite->user_id = $userId;
        $favorite->name = $name;
        $favorite->save();
    }

    /**
     * Save the favorites list to the session for guests.
     *
     * @param int $userId
     * @param string $name
     * @return void
     */
    private function saveToSession(int $userId, string $name): void
    {
        // Get the session instance
        $session = session();

        // Check if the favorites list already exists
        if (!$session->has('favorites')) {
            // Initialize the favorites list
            $session->put('favorites', []);
        }

        // Add the business name to the favorites list
        $session->push('favorites', [
            'user_id' => $userId,
            'name' => $name,
        ]);
    }

    /**
     * Remove a business name from the database for logged-in users.
     *
     * @param int $userId
     * @param string $name
     * @return void
     */
    private function removeFromDatabase(int $userId, string $name): void
    {
        // Delete the Favorite instance
        Favorite::where('user_id', $userId)->where('name', $name)->delete();
    }

    /**
     * Remove a business name from the session for guests.
     *
     * @param int $userId
     * @param string $name
     * @return void
     */
    private function removeFromSession(int $userId, string $name): void
    {
        // Get the session instance
        $session = session();

        // Get the favorites list
        $favorites = $session->get('favorites');

        // Filter out the business name
        $session->put('favorites', array_filter($favorites, function ($favorite) use ($userId, $name) {
            return $favorite['user_id'] !== $userId || $favorite['name'] !== $name;
        }));
    }
}
```

**Favorites Controller**

The `FavoritesController` acts as an API to connect the Vue frontend to the `FavoritesManager` class.

```php
namespace App\Http\Controllers;

use App\Favorites\FavoritesManager;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class FavoritesController extends Controller
{
    /**
     * Add a business name to the user's favorites list.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function add(Request $request)
    {
        $favoritesManager = new FavoritesManager();
        $favoritesManager->add(Auth::id(), $request->input('name'));

        return response()->json(['message' => 'Business name added to favorites']);
    }

    /**
     * Remove a business name from the user's favorites list.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function remove(Request $request)
    {
        $favoritesManager = new FavoritesManager();
        $favoritesManager->remove(Auth::id(), $request->input('name'));

        return response()->json(['message' => 'Business name removed from favorites']);
    }
}
```

This implementation provides a `FavoritesManager` class that handles adding and removing business names from a user's favorites list. It saves the list to the database for logged-in users and to the session for guests. The `FavoritesController` acts as an API to connect the Vue frontend to this class.

**Example Use Cases**

1. **Adding a Business Name**:

   - **Logged-in User**: Send a `POST` request to `/api/favorites/add` with the business name in the request body.
   - **Guest**: Send a `POST` request to `/api/favorites/add` with the business name in the request body.

2. **Removing a Business Name**:

   - **Logged-in User**: Send a `POST` request to `/api/favorites/remove` with the business name in the request body.
   - **Guest**: Send a `POST` request to `/api/favorites/remove` with the business name in the request body.

**API Endpoints**

- **`/api/favorites/add`**: Add a business name to the user's favorites list.
- **`/api/favorites/remove`**: Remove a business name from the user's favorites list.