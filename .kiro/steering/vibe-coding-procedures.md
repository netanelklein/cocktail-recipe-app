---
inclusion: always
---

# Cocktailian Development Guidelines

## Project Context

**Status**: Phase 0 complete (Widget Library + Theme System), transitioning to Phase 1 (Core Discovery Engine)
**Architecture**: Flutter + Firebase + Riverpod state management
**Target**: Cocktail recipe app with ingredient-based filtering for home bartenders

## Code Standards

### Architecture Patterns

- **State Management**: Riverpod exclusively - no other state solutions
- **File Structure**: Follow established `/lib` organization (core/, data/, providers/, widgets/, screens/)
- **Import Order**: External packages → internal imports → relative imports
- **Widget Library**: Use custom `Bar*` widgets from `lib/widgets/common/` (BarButton, BarCard, BarChip, etc.)

### Theme System (Critical)

- **Zero Hardcoded Colors**: All widgets must use `Theme.of(context).colorScheme.*`
- **4-Palette System**: Midnight Martini, Whiskey Barrel, Neon Nights, Forest Gin
- **Border Radius Standards**:
  - Buttons: 30px (very rounded)
  - Input fields: 25px (highly rounded)
  - Cards/chips: 20px (moderately rounded)
- **Theme Compliance**: Run `flutter analyze` to catch hardcoded color violations

### Code Quality

- **Analysis**: Zero warnings/errors from `flutter analyze` before commits
- **Testing**: Write tests for all widgets and business logic
- **Formatting**: Follow Dart style guide with auto-formatting

## Development Workflow

### Git Conventions

- **Branches**: `feature/issue-{number}-{description}`, `fix/issue-{number}-{description}`
- **Commits**: Semantic commits with clear descriptions
- **Workflow**: Feature branches for all changes (enables easy reverting)

### Session Protocol

1. Read `ai-context.md` first to understand current project state
2. Work on one issue/feature at a time with clear deliverables
3. Update `ai-context.md` after completing significant work
4. Ask for approval before major architectural changes

### Firebase Integration

- **Backend**: Firestore + Auth + Storage configured and ready
- **Collections**: Follow established schema patterns
- **Security**: Use Firebase rules for data protection

## Current Development Phase

- **Phase 0**: ✅ Complete (Widget Library + Theme System)
- **Phase 1**: Core Discovery Engine (ingredient filtering, recipe viewing)
- **Timeline**: 24-week plan, 10-15 hours/week capacity
- **Platform Priority**: Android first, then iOS/web

## Key Constraints

- **No Hardcoded Colors**: Theme system must be used throughout
- **Widget Consistency**: Use Bar\* widget library for all UI components
- **Firebase-First**: All data operations through Firebase services
- **Testing Required**: All new widgets and logic must have tests
