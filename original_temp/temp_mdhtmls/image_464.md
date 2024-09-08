To initialize a TypeScript project using npm and git, follow these steps:

1. Open your terminal or command prompt.
2. Navigate to the directory where you want to create your project.
3. Run the following command to initialize a new npm project:
```
npm init -y
```
This will create a package.json file in your project directory.

4. Install TypeScript by running the following command:
```
npm install typescript --save-dev
```
This will install TypeScript as a development dependency in your project.

5. Create a tsconfig.json file by running the following command:
```
npx tsc --init
```
This will create a tsconfig.json file in your project directory with default settings.

6. Initialize a new git repository by running the following command:
```
git init
```
This will create a new git repository in your project directory.

7. Add the package.json and tsconfig.json files to the git repository by running the following command:
```
git add package.json tsconfig.json
```
8. Commit the changes to the git repository by running the following command:
```
git commit -m "Initial commit"
```

Congratulations! You have now initialized a TypeScript project using npm and git.