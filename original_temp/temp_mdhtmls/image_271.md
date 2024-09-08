Sure! Here's a data model for a test automation tool considering organizations, users, projects, goals (under projects), tests (under goals) and executions (of test cases) with a date and passed/failed status:

Entities:
- Organization
- User
- Project
- Goal (under Project)
- Test (under Goal)
- Execution (of Test Case)

Relationships:
- One-to-many: Organization has many Projects
- One-to-many: Project has many Goals
- One-to-many: Goal has many Tests
- One-to-many: Test has many Executions
- One-to-many: User has many Executions (through many-to-many relationship with Projects)

Attributes:
- Organization: name, description
- User: name, email, role (e.g. admin, developer, tester)
- Project: name, description, start date, end date
- Goal: name, description, priority (e.g. high, medium, low)
- Test: name, description, type (e.g. unit test, integration test, end-to-end test)
- Execution: date, passed/failed status, test case name, test case description, test case type, test case result (e.g. passed, failed, skipped), test case duration, test case author, test case version

This data model allows for tracking test automation efforts across organizations, projects, goals, tests, and executions. It also provides a way to associate users with specific projects and executions, allowing for role-based access control and collaboration.