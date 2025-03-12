# GIT
## BRANCHES
Template: `<type>/<issue>/<description>`

## COMMITS
Template: `<type>(scope): <description>`

### TYPES:
- build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- docs: Documentation and repository configuration only changes
- feat: A new feature
- fix: A bug fix
- perf: A code change that improves performance
- refactor: A code change that neither fixes a bug nor adds a feature
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- test: Adding missing tests or correcting existing tests


# Makefile

| Command     | Description                                         |
|-------------|-----------------------------------------------------|
| init        | This command is used to initialize the project.     |
| setup       | Downloads and updates the backend submodule.        |
| venv        | Updates the local virtual environment.              |
| build       | Builds the Docker containers.                       |
| up          | Starts the Docker containers.                       |
| down        | Stops the Docker containers.                        |
| requirements| Installs required dependencies inside the container.|

