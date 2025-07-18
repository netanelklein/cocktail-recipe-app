---
inclusion: always
---

# Development Standards & Guidelines

## Overview

Comprehensive development standards, coding practices, and quality guidelines for the cocktail recipe app. These standards ensure consistent, maintainable, and high-quality code throughout the 24-week development timeline.

**Priority**: High (guides all development work)  
**Phase**: Foundation (applies to all phases)

## Code Quality Standards

### Flutter Development Guidelines

#### Widget Development Standards

- Follow Material Design 3 principles
- Implement responsive design for multiple screen sizes
- Use Riverpod for all state management
- Create reusable, composable widgets
- Maintain consistent naming conventions (PascalCase for classes, camelCase for variables)

#### State Management with Riverpod

- Use Provider for global state
- Use StateProvider for simple state
- Use StateNotifierProvider for complex state with business logic
- Implement proper provider disposal
- Follow unidirectional data flow patterns

#### Code Organization

```
lib/
├── core/
│   ├── constants/        # App constants, colors, strings
│   ├── themes/          # Dark bar aesthetic theme
│   ├── utils/           # Utility functions
│   └── extensions/      # Dart extensions
├── data/
│   ├── models/          # Data models (Recipe, Ingredient, User)
│   ├── repositories/    # Data access layer
│   └── services/        # Firebase services
├── providers/           # Riverpod providers
├── widgets/
│   ├── common/          # Reusable UI components
│   ├── cards/           # Cocktail cards, ingredient cards
│   ├── forms/           # Input forms and fields
│   └── navigation/      # Navigation components
├── screens/
│   ├── discovery/       # Home, search, filter screens
│   ├── inventory/       # Ingredient management
│   ├── recipe/          # Recipe details and submission
│   └── profile/         # User profile and settings
└── main.dart
```

### Code Quality Requirements

#### Pre-Commit Checklist (MANDATORY)

**All of these must pass before any commit:**

1. **Code Formatting**: `dart format .`

   - Must format all Dart files
   - Zero tolerance for unformatted code

2. **Static Analysis**: `flutter analyze`

   - Must pass with zero warnings or errors
   - No exceptions allowed

3. **Test Suite**: `flutter test`

   - All tests must pass
   - No failing or skipped tests allowed
   - Warnings are acceptable but should be addressed

4. **Build Verification**: `flutter build apk --debug` (optional but recommended)
   - Ensure app builds successfully
   - Catch build-time issues early

#### Analysis Standards

- `flutter analyze` must pass with zero warnings or errors
- Custom lint rules for project-specific requirements
- Consistent import organization (external → internal → relative)
- No unused imports or dead code

#### Formatting Standards

- Use `dart format` with default settings
- Line length limit: 80 characters
- Consistent code style across all files
- Proper documentation formatting

#### Documentation Requirements

- Dartdoc comments for all public APIs
- Class-level documentation explaining purpose
- Method documentation with parameter descriptions
- Example usage for complex widgets
- README updates for architectural changes

## Testing Standards

### Comprehensive Testing Strategy

#### Widget Testing (Mandatory)

- Every custom widget must have corresponding tests
- Test widget rendering and basic interactions
- Test responsive behavior across screen sizes
- Test dark theme rendering and bar aesthetic elements
- Mock external dependencies (Firebase, network calls)

#### Unit Testing Requirements

- Test all business logic and utility functions
- Test data models and their methods
- Test provider logic and state changes
- Test algorithm implementations (filtering, sorting)
- Achieve minimum 80% code coverage

#### Integration Testing

- Test critical user flows end-to-end
- Test Firebase integration with real backend
- Test navigation between screens
- Test offline functionality where applicable
- Performance testing for key operations

#### Testing Structure

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
    ├── user_flows/      # End-to-end user scenarios
    ├── firebase/        # Backend integration tests
    └── performance/     # Performance testing
```

## Development Workflow Standards

### Git Workflow

#### Commit Message Standards

```
type(scope): description

Types: feat, fix, docs, style, refactor, test, chore
Scope: widget, provider, service, ui, data

Examples:
- feat(widget): add cocktail card with bar aesthetic
- fix(provider): resolve ingredient filtering bug
- docs(readme): update setup instructions
```

#### Branch Naming Convention

**Phase 1 (main branch only):**

- Direct commits to main with descriptive messages

**Post-Release:**

- `feature/widget-design-system`
- `fix/recipe-filtering-bug`
- `docs/api-documentation-update`

### Code Review Process

#### Self-Review Checklist

- Code follows established patterns
- All tests pass locally
- Documentation is updated
- No debug prints or commented code
- Performance implications considered
- Accessibility guidelines followed

#### Pre-Merge Requirements

- `flutter analyze` passes with zero issues
- All tests pass (`flutter test`)
- Code formatting applied (`dart format`)
- Functionality tested on target devices
- No breaking changes without migration plan

## Performance Standards

### App Performance Requirements

#### Startup Performance

- Cold start time < 3 seconds on mid-range Android devices
- Splash screen with bar aesthetic branding
- Progressive loading of non-critical features
- Efficient Firebase initialization

#### Runtime Performance

- Screen navigation < 300ms response time
- Real-time ingredient filtering < 100ms response
- Smooth scrolling at 60fps minimum
- Memory usage optimization with image caching

#### Network Performance

- Efficient Firebase query patterns
- Image compression and caching strategy
- Offline functionality for core features
- Progressive loading for recipe content

### Performance Monitoring

#### Metrics Tracking

- App startup time measurement
- Screen rendering performance
- Memory usage profiling
- Network request monitoring
- User interaction latency

## Accessibility Standards

### Inclusive Design Requirements

#### Screen Reader Support

- Proper semantic labels for all interactive elements
- Meaningful descriptions for images and icons
- Logical focus order and navigation
- Alternative text for bar aesthetic visual elements

#### Visual Accessibility

- Color contrast ratios meet WCAG 2.1 AA standards (4.5:1 minimum)
- Text scaling support up to 200%
- Clear focus indicators with gold outline
- Support for system-level accessibility settings

#### Motor Accessibility

- Touch targets minimum 44px × 44px
- Adequate spacing between interactive elements
- Support for switch control and external keyboards
- Alternative input methods for complex gestures

## Security Standards

### Data Protection

#### Input Validation

- Sanitize all user inputs
- Validate data types and ranges
- Prevent injection attacks
- Rate limiting for user submissions

#### Firebase Security

- Implement proper Firestore security rules
- Use Firebase Authentication for user management
- Protect API keys and sensitive configuration
- Regular security rule audits

### Privacy Compliance

#### Data Minimization

- Collect only necessary user data
- Clear data retention policies
- User consent for optional data collection
- Transparent privacy policy

## Dark Bar Aesthetic Implementation

### Design System Consistency

#### Color Usage Standards

- Primary dark: #1A1A1A (backgrounds)
- Gold accent: #FFD700 (interactive elements, highlights)
- Copper/bronze: #B87333 (secondary accents)
- Error red: #EF4444 (missing ingredients)
- Success green: #22C55E (available ingredients)

#### Typography Standards

- Cocktail names: Elegant serif fonts
- Body text: Clean sans-serif
- Measurements: Monospace for precision
- Consistent font scaling and line heights

#### Component Styling

- Gradient backgrounds for cards and buttons
- Subtle shadows and glass effects
- Smooth animations (300ms standard)
- Consistent border radius (20px standard, 30px for buttons)

## Error Handling Standards

### Graceful Degradation

#### User-Facing Errors

- Clear, actionable error messages
- Bar-themed error illustrations
- Retry mechanisms for network issues
- Fallback content for missing data

#### Developer Error Handling

- Comprehensive error logging
- Firebase Crashlytics integration
- Performance issue tracking
- Proactive error monitoring

## Documentation Maintenance

### Living Documentation

#### Project Documentation

- Keep `.ai-context.md` updated with major decisions
- Maintain architectural decision records (ADRs)
- Update API documentation with changes
- Regular README maintenance

#### Design Documentation

- Widget library documentation
- Style guide maintenance
- Component usage examples
- Design pattern documentation

## Success Criteria

- All development follows established standards
- Code quality metrics consistently met
- Testing coverage maintains 80%+ threshold
- Performance targets achieved across all features
- Accessibility compliance verified
- Security standards implemented and audited

## Enforcement Strategy

- CI/CD pipeline enforces all quality gates
- Regular code quality audits
- Performance monitoring alerts
- Documentation review process
- Standards compliance tracking

---

_These standards apply to all phases and must be maintained throughout the 24-week development timeline._
