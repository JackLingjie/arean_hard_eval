Here's an example of a GitHub Actions workflow that demonstrates the CI/CD features:

```yaml
name: CI/CD Workflow

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Node.js
        uses: actions/setup-node@v1
        with:
          node-version: 12

      - name: Install dependencies
        run: npm install

      - name: Lint with ESLint
        run: npm run lint

      - name: Test with Jest
        run: npm test

      - name: Build with Webpack
        run: npm run build

      - name: Deploy to GitHub Pages
        uses: JamesIves/github-pages-deploy-action@3.6.0
        with:
          branch: gh-pages
          folder: public
```

This workflow is triggered on every push to the repository. It consists of several jobs, each of which performs a specific task in the CI/CD process. The first job, `build`, runs on the latest version of Ubuntu and performs the following steps:

1. Checks out the repository using the `actions/checkout` action.
2. Sets up Node.js using the `actions/setup-node` action.
3. Installs dependencies using `npm install`.
4. Lints the code using `npm run lint`.
5. Runs tests using `npm test`.
6. Builds the application using `npm run build`.
7. Deploys the built application to GitHub Pages using the `JamesIves/github-pages-deploy-action`.

This workflow demonstrates how GitHub Actions can be used to automate the CI/CD process for a Node.js application. By defining the workflow as a YAML file in the repository, it can be easily shared and reused by other developers. Additionally, the workflow can be triggered automatically when changes are pushed to the repository, ensuring that the application is always built and deployed in a consistent and reliable manner.