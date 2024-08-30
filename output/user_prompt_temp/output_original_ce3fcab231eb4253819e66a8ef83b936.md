<|User Prompt|>
Write me a wordpress plugin that clears all nginx helper cache when plugin/theme is added/updated/changed 

<|The Start of Assistant A's Answer|>
Creating a WordPress plugin that clears all Nginx Helper cache when a plugin or theme is added, updated, or changed requires some knowledge of PHP and WordPress hooks. Here's a basic outline of the plugin:

1. Create a new folder in your WordPress installation's `wp-content/plugins` directory, and name it something like `clear-nginx-cache-on-update`.

2. Inside the new folder, create a PHP file with the same name as the folder, for example, `clear-nginx-cache-on-update.php`.

3. Open the PHP file and add the following code to create the plugin header:

```php
<?php
/**
 * Plugin Name: Clear Nginx Cache on Update
 * Plugin URI: https://www.example.com/
 * Description: This plugin clears the Nginx Helper cache when a plugin or theme is added, updated, or changed.
 * Version: 1.0.0
 * Author: Your Name
 * Author URI: https://www.example.com/
 * License: GPL-2.0+
 * License URI: http://www.gnu.org/licenses/gpl-2.0.txt
 */
```

4. Now, add the function that will clear the Nginx Helper cache:

```php
function clear_nginx_cache_on_update() {
    if (function_exists('rt_nginx_helper_purge_all')) {
        rt_nginx_helper_purge_all();
    }
}
```

5. Next, add the WordPress hooks that will trigger the cache clearing function when a plugin or theme is added, updated, or changed:

```php
add_action('upgrader_process_complete', 'clear_nginx_cache_on_update', 10, 2);
add_action('switch_theme', 'clear_nginx_cache_on_update');
add_action('wp_update_nav_menu', 'clear_nginx_cache_on_update');
```

6. Save the file and close it.

7. Log in to your WordPress admin dashboard, go to the "Plugins" page, and activate the "Clear Nginx Cache on Update" plugin.

Now, whenever a plugin or theme is added, updated, or changed, the Nginx Helper cache will be cleared automatically. Note that this plugin assumes you have the Nginx Helper plugin installed and activated. If you don't, the `function_exists('rt_nginx_helper_purge_all')` check will prevent any errors.
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
**Nginx Helper Cache Clearer Plugin**

### Description

This WordPress plugin clears the Nginx helper cache when a plugin or theme is added, updated, or changed.

### Installation

1. **Upload the Plugin**:
   - Upload the `nginx-cache-clearer` folder to the `/wp-content/plugins/` directory.

2. **Activate the Plugin**:
   - Activate the plugin through the WordPress admin interface.

### Code

```php
<?php
/*
Plugin Name: Nginx Helper Cache Clearer
Description: Clears Nginx helper cache when a plugin or theme is added, updated, or changed.
Version: 1.0
Author: [Your Name]
Author URI: https://[Your Website]
*/

// Hook to clear cache on plugin activation
function clear_cache_on_plugin_activation() {
    // Clear cache for all plugins
    $plugins = get_plugins();
    foreach ($plugins as $plugin_path => $plugin_data) {
        clear_cache($plugin_path);
    }
}

// Hook to clear cache on plugin update
function clear_cache_on_plugin_update($plugin) {
    clear_cache($plugin);
}

// Hook to clear cache on plugin deactivation
function clear_cache_on_plugin_deactivation($plugin) {
    clear_cache($plugin);
}

// Hook to clear cache on theme activation
function clear_cache_on_theme_activation($theme) {
    clear_cache($theme);
}

// Hook to clear cache on theme update
function clear_cache_on_theme_update($theme) {
    clear_cache($theme);
}

// Function to clear cache
function clear_cache($file_path) {
    // Assuming the cache is stored in the 'wp-content/cache/nginx' directory
    $cache_dir = WP_CONTENT_DIR . '/cache/nginx';
    
    // Check if the cache directory exists
    if (file_exists($cache_dir)) {
        // Get a list of files in the cache directory
        $files = scandir($cache_dir);
        
        // Iterate over each file
        foreach ($files as $file) {
            // Skip current and parent directories
            if ($file == '.' || $file == '..') {
                continue;
            }
            
            // Construct the full path to the file
            $file_path = $cache_dir . '/' . $file;
            
            // Check if the file is a cache file
            if (strpos($file, 'nginx-') === 0) {
                // Delete the cache file
                unlink($file_path);
            }
        }
    }
}

// Hook to clear cache on plugin update
add_action('activated_plugin', 'clear_cache_on_plugin_activation');
add_action('switch_theme', 'clear_cache_on_theme_activation');
add_action('update_plugin', 'clear_cache_on_plugin_update');
add_action('deactivate_plugin', 'clear_cache_on_plugin_deactivation');
add_action('switch_theme', 'clear_cache_on_theme_activation');
add_action('update_theme', 'clear_cache_on_theme_update');
```

### Usage

1. **Upload the Plugin**:
   - Upload the `nginx-cache-clearer` folder to the `/wp-content/plugins/` directory.

2. **Activate the Plugin**:
   - Activate the plugin through the WordPress admin interface.

### Notes

- This plugin assumes the Nginx helper cache is stored in the `wp-content/cache/nginx` directory.
- The plugin clears cache files that start with `nginx-`.
- The plugin hooks into WordPress actions to clear the cache when a plugin or theme is added, updated, or changed.
<|The End of Assistant B's Answer|>