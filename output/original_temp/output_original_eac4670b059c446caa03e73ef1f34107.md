**Using `@tanstack/vue-query` with Pinia Store**

To fetch data from `/get_session` and update specific keys in a global Pinia store using `@tanstack/vue-query`, follow these steps:

### Step 1: Install Required Packages

First, ensure you have the necessary packages installed:

```bash
npm install @tanstack/vue-query pinia
```

### Step 2: Set Up Pinia Store

Create a Pinia store to manage your global state. For example, create a file named `stores/sessionStore.js`:

```javascript
// stores/sessionStore.js
import { defineStore } from 'pinia';

export const useSessionStore = defineStore('session', {
  state: () => ({
    sessionData: {}, // Initialize with an empty object
  }),
});
```

### Step 3: Use `@tanstack/vue-query` to Fetch Data

Next, use `@tanstack/vue-query` to fetch data from `/get_session` and update the Pinia store:

```javascript
// componenets/SessionComponent.vue
<template>
  <!-- Your template here -->
</template>

<script>
import { useSessionStore } from '../stores/sessionStore';
import { useQuery } from '@tanstack/vue-query';

const sessionStore = useSessionStore();

export default {
  setup() {
    const { data, error, isLoading } = useQuery(
      ['sessionData'], // The key for the query
      async () => {
        const response = await fetch('/get_session');
        return response.json();
      },
      {
        // Options for the query
        onSuccess: (data) => {
          // Update the Pinia store with the selected keys
          sessionStore.sessionData = {
            // Select specific keys from the response
            userId: data.userId,
            userName: data.userName,
          };
        },
      }
    );

    return { data, error, isLoading };
  },
};
</script>
```

### Step 4: Use the Updated Store

Finally, use the updated store in your components:

```javascript
// components/AnotherComponent.vue
<template>
  <!-- Use the updated store -->
  <p>Username: {{ sessionStore.sessionData.userName }}</p>
</template>

<script>
import { useSessionStore } from '../stores/sessionStore';

export default {
  setup() {
    const sessionStore = useSessionStore();

    return { sessionStore };
  },
};
</script>
```

This example demonstrates how to fetch data from `/get_session`, select specific keys, and update a global Pinia store using `@tanstack/vue-query`.