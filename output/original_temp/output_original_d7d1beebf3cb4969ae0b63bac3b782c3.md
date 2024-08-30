**Designing a Versioned SQL Schema**

To achieve a versioned SQL schema while maintaining referential integrity, follow these steps:

### Step 1: **Introduce a Versioning Table**

Create a separate table to store schema versions. This table will keep track of the current and previous schema versions.

```sql
CREATE TABLE schema_versions (
    id SERIAL PRIMARY KEY,
    version INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

### Step 2: **Use a Version Column**

Add a `version` column to each table that needs versioning. This column will store the current version of the table.

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL DEFAULT 1
);
```

### Step 3: **Enforce Referential Integrity**

To maintain referential integrity, use foreign keys that reference the `version` column.

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    version INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT fk_user FOREIGN KEY (user_id, version) REFERENCES users (id, version)
);
```

### Step 4: **Update Versioning Logic**

When updating the schema, follow these steps:

1. **Update the `schema_versions` table**:
   - Insert a new version with the updated schema.
   - Update the `version` column in the `schema_versions` table.

2. **Update the `version` column**:
   - Update the `version` column in the affected tables.

3. **Update foreign key constraints**:
   - Update the foreign key constraints to reference the new version.

### Example Use Case

Suppose you want to add a new column `phone_number` to the `users` table.

1. **Insert a new version**:
   ```sql
INSERT INTO schema_versions (version) VALUES (2);
```

2. **Update the `users` table**:
   ```sql
ALTER TABLE users ADD COLUMN phone_number VARCHAR(20);
UPDATE users SET version = 2;
```

3. **Update foreign key constraints**:
   ```sql
ALTER TABLE orders DROP CONSTRAINT fk_user;
ALTER TABLE orders ADD CONSTRAINT fk_user FOREIGN KEY (user_id, version) REFERENCES users (id, version);
```

By following these steps, you can maintain referential integrity while versioning your SQL schema.

### Example Use Case Code

```sql
-- schema_versions table
CREATE TABLE schema_versions (
    id SERIAL PRIMARY KEY,
    version INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL DEFAULT 1
);

-- orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    version INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT fk_user FOREIGN KEY (user_id, version) REFERENCES users (id, version)
);

-- Insert a new version
INSERT INTO schema_versions (version) VALUES (2);

-- Update the users table
ALTER TABLE users ADD COLUMN phone_number VARCHAR(20);
UPDATE users SET version = 2;

-- Update foreign key constraints
ALTER TABLE orders DROP CONSTRAINT fk_user;
ALTER TABLE orders ADD CONSTRAINT fk_user FOREIGN KEY (user_id, version) REFERENCES users (id, version);
```