**Connecting Databricks SQL to Ingestion Tools like Fivetran**

### Overview

Databricks SQL is a fast, scalable, and secure analytics database. To integrate it with ingestion tools like Fivetran, follow these steps:

### Step 1: **Create a Databricks SQL Endpoint**

1. **Log in** to your Databricks account.
2. **Navigate** to the **SQL** tab.
3. **Click** on **Endpoints**.
4. **Create a new endpoint** with the following details:
   - **Endpoint Name**: Choose a descriptive name.
   - **Host**: The host URL of your Databricks SQL instance.
   - **Port**: The port number (default is 443).
   - **Authentication**: Select **OAuth**.

### Step 2: **Generate an OAuth Token**

1. **Navigate** to the **User Settings**.
2. **Click** on **Account**.
3. **Scroll down** to the **OAuth** section.
4. **Click** on **Generate Token**.
5. **Copy** the generated token.

### Step 3: **Configure Fivetran**

1. **Log in** to your Fivetran account.
2. **Navigate** to the **Sources** tab.
3. **Click** on **Create Source**.
4. **Select** **Databricks SQL** as the source.
5. **Enter** the following details:
   - **Endpoint**: The endpoint name created in Step 1.
   - **OAuth Token**: The token generated in Step 2.
   - **Database**: The database name in your Databricks SQL instance.

### Step 4: **Test the Connection**

1. **Click** on **Test Connection**.
2. **Verify** that the connection is successful.

### Step 5: **Schedule Data Ingestion**

1. **Configure** the data ingestion schedule according to your needs.
2. **Start** the data ingestion process.

### Example Use Case

- **Use Case**: Integrate a customer database in Databricks SQL with a marketing analytics platform using Fivetran.
- **Steps**:
  - Create a Databricks SQL endpoint.
  - Generate an OAuth token.
  - Configure Fivetran to connect to the Databricks SQL endpoint.
  - Test the connection.
  - Schedule data ingestion.

### Code Snippets

- **Databricks SQL Endpoint Creation**:
```sql
CREATE ENDPOINT my_endpoint
  HOST 'https://<databricks-instance>.cloud.databricks.com'
  PORT 443
  AUTHENTICATION OAuth;
```

- **Fivetran Configuration**:
```json
{
  "name": "Databricks SQL Source",
  "type": "databricks_sql",
  "endpoint": "my_endpoint",
  "oauth_token": "<oauth-token>",
  "database": "my_database"
}
```

### Commit Message Guidelines

- **Use imperative mood** (e.g., "Create Databricks SQL endpoint").
- **Keep it concise** (max 50 characters).
- **Use present tense** (e.g., "Create" instead of "Created").

### API Documentation Guidelines

- **Use clear and concise language**.
- **Include code snippets**.
- **Provide example use cases**.
- **Use proper formatting**.