# Contributing to Cocktail Recipe Community App

## Project Status

**Current Phase**: Phase 0 (Foundation) - Weeks 1-2  
**Development Model**: Solo development through Phase 2, community contributions welcome starting Phase 3  
**Timeline**: 24-week development plan with 5 distinct phases

## Development Workflow

### Phase 0-2: Solo Development (Current)

#### Branching Strategy
- **Main branch only** for Phase 0-1 (direct commits)
- **Feature branches** starting Phase 2 for larger features
- All commits must follow established standards

#### Commit Message Format
```
type(scope): description

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation changes
- style: Formatting changes
- refactor: Code restructuring
- test: Adding or updating tests
- chore: Maintenance tasks

Scopes:
- widget: UI components
- provider: State management
- service: Data services
- ui: User interface
- data: Data models
- infra: Infrastructure
- docs: Documentation

Examples:
- feat(widget): add cocktail card with bar aesthetic
- fix(provider): resolve ingredient filtering bug
- docs(readme): update setup instructions
- test(service): add Firebase integration tests
```

### Code Quality Requirements

#### Pre-Commit Checklist
- [ ] `flutter analyze` passes with zero warnings or errors
- [ ] All new code has corresponding tests
- [ ] Code follows established widget library patterns
- [ ] Dark bar aesthetic maintained consistently
- [ ] Performance implications considered
- [ ] Documentation updated if needed

#### Testing Standards
- **Unit Tests**: All business logic and data models
- **Widget Tests**: Every custom UI component
- **Integration Tests**: Critical user flows
- **Minimum Coverage**: 80% code coverage
- **Performance Tests**: Filtering and navigation speed

#### Code Style Standards
- Follow Dart/Flutter style guidelines
- Use `dart format` with default settings
- Consistent import organization (external → internal → relative)
- Meaningful variable and function names
- Comprehensive documentation for public APIs

### Development Environment

#### Required Tools
- Flutter SDK (latest stable)
- Firebase CLI
- Android Studio or VS Code with Flutter extensions
- Git with GitHub CLI (optional but recommended)

#### IDE Configuration
- Use GitHub Copilot with `@github` commands for issue management
- Reference `.ai-context.md` for project context
- Maintain connection between code and GitHub issues

#### Local Development Workflow
1. **Pull latest changes**: `git pull origin main`
2. **Create feature branch** (Phase 2+): `git checkout -b feature/widget-name`
3. **Implement changes** following code standards
4. **Run tests**: `flutter test`
5. **Check analysis**: `flutter analyze`
6. **Format code**: `dart format .`
7. **Commit changes** with proper message format
8. **Push and create PR** (Phase 2+) or direct push (Phase 0-1)

### Issue Management

#### Current Issues Priority
1. [**Phase 0: Widget Design Library**](../../issues/1) - Immediate priority
2. [**CI/CD Pipeline & Infrastructure Setup**](../../issues/3) - Parallel with #1
3. [**Development Standards & Guidelines**](../../issues/4) - Reference document
4. [**Phase 1: Core Discovery Engine Implementation**](../../issues/5) - Next phase

#### Issue Workflow
- **Reference issue numbers** in commit messages
- **Update issue progress** with checkboxes
- **Link code to issues** for traceability
- **Close issues** when fully implemented and tested

#### Creating New Issues
- Use established label system (phase-*, priority-*, component-*)
- Assign to appropriate milestone
- Include acceptance criteria and success metrics
- Reference related issues and dependencies

### Documentation Standards

#### Documentation Requirements
- **Update `.ai-context.md`** for major architectural decisions
- **Maintain README.md** with current project status
- **Document new widgets** in design library
- **Update API documentation** for new services
- **Include code examples** for complex implementations

#### Documentation Workflow
- Document as you develop, not after
- Use clear, actionable language
- Include screenshots for UI components
- Maintain consistency with project terminology

### Testing Strategy

#### Test Organization
```
test/
├── unit/
│   ├── models/          # Data model tests
│   ├── providers/       # Provider logic tests
│   ├── services/        # Service layer tests
│   └── utils/           # Utility function tests
├── widget/
│   ├── common/          # Common widget tests
│   ├── screens/         # Screen widget tests
│   └── components/      # Component widget tests
└── integration/
    ├── user_flows/      # End-to-end scenarios
    ├── firebase/        # Backend integration
    └── performance/     # Performance testing
```

#### Testing Standards
- **Mock external dependencies** (Firebase, network calls)
- **Test widget rendering** across screen sizes
- **Test dark theme** and bar aesthetic elements
- **Test user interactions** and state changes
- **Test error handling** and edge cases

### Performance Standards

#### Performance Targets
- **App startup**: < 3 seconds cold start
- **Navigation**: < 300ms screen transitions
- **Filtering**: < 100ms ingredient filter response
- **Memory**: Efficient image and data caching
- **Battery**: Minimal background processing

#### Performance Testing
- Test on mid-range Android devices
- Monitor memory usage patterns
- Profile animation performance
- Test offline functionality

### Security Standards

#### Data Protection
- **Input validation** for all user data
- **Firebase security rules** properly configured
- **API key protection** in environment variables
- **User data minimization** principles

#### Privacy Compliance
- **Clear data collection** policies
- **User consent** for optional features
- **Data retention** policies implemented
- **Transparent privacy** practices

## Phase-Specific Guidelines

### Phase 0: Foundation (Current)
**Focus**: Widget design library and infrastructure setup
- Establish dark bar aesthetic theme
- Create reusable UI components
- Set up Firebase infrastructure
- Implement CI/CD pipeline

**Key Deliverables**:
- Complete widget library with bar aesthetic
- Firebase development/production environments
- CI/CD pipeline with automated testing
- Development environment documentation

### Phase 1: Core Discovery Engine
**Focus**: Ingredient management and recipe discovery
- Implement ingredient database
- Build filtering algorithms
- Create recipe display system
- Develop real-time suggestions

### Phase 2: Menu Planning & Utilities
**Focus**: Planning tools and utilities
- Menu planning interface
- Shopping list generation
- Recipe scaling features
- Print-friendly formats

### Phase 3: Community Foundation
**Focus**: User-generated content foundation
- User authentication system
- Recipe submission workflow
- Rating and review system
- Content moderation tools

### Phase 4: Advanced Community
**Focus**: Enhanced social features and launch preparation
- Advanced search and filtering
- User profiles and favorites
- Social sharing features
- Launch optimization

## Community Contributions (Phase 3+)

### Future Contribution Areas
- **Recipe Content**: High-quality cocktail recipes
- **Ingredient Database**: Expanded ingredient information
- **Translations**: Internationalization support
- **Platform Support**: iOS and web optimization
- **Accessibility**: Enhanced accessibility features

### Community Guidelines (Future)
- **Code of Conduct**: Respectful and inclusive environment
- **Quality Standards**: Maintain high code and content quality
- **Review Process**: Thorough review for community contributions
- **Recognition**: Credit contributors appropriately

## Getting Help

### Current Support (Solo Development)
- **Issue Tracking**: Use GitHub issues for bug reports and feature requests
- **Documentation**: Refer to `.ai-context.md` and `/docs` folder
- **Code Context**: Use GitHub Copilot with `@github` commands

### Future Community Support (Phase 3+)
- **Discussion Forums**: Community discussions and Q&A
- **Contribution Guides**: Detailed guides for specific contribution types
- **Mentorship**: Support for new contributors

---

**Last Updated**: 2025-06-19 21:32:07 UTC  
**Status**: Foundation guidelines established for Phase 0 development  
**Next Review**: After Phase 1 completion for community preparation
