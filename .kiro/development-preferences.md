# Development Preferences

## Scripting

- **Preferred**: Bash scripts (.sh files) ONLY
- **Strictly Avoid**: Node.js scripts, Python scripts, or any other scripting languages
- **Reason**: Keep the project clean and avoid unnecessary dependencies
- **Rule**: ALL scripts must be written in bash, no exceptions
- **Note**: If bash cannot accomplish the task, find an alternative approach or use existing CLI tools

## Project Structure

- Keep root directory clean
- Avoid `node_modules/` in Flutter project root
- Use platform-appropriate tooling (Flutter/Dart tools for Flutter project)

## Git Workflow

- Use feature branches for development
- Clean commits with clear messages
- Review changes before merging

---

_These preferences should be followed for all future development_
