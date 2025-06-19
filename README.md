# Cocktail Recipe Community App

A Flutter-based cocktail discovery app focused on ingredient-based filtering with community features and commercial viability potential.

## 🎯 Project Vision
Transform home bartending by helping cocktail enthusiasts discover recipes based on their available ingredients, with a sophisticated dark bar aesthetic and community-driven content.

## 📱 Core Features

### MVP Features (Phases 0-2)
- **Ingredient-based filtering** - Find cocktails you can make right now
- **Personal ingredient inventory** - Track what you have at home
- **Recipe discovery engine** - Smart suggestions with substitutions
- **Menu planning tools** - Plan cocktails for events
- **Shopping list generation** - Never forget an ingredient

### Community Features (Phases 3-4)
- **User recipe submissions** - Share your creations
- **Rating & review system** - Community-driven quality
- **Recipe scaling & conversions** - Perfect portions every time
- **Advanced filtering** - By taste profile, difficulty, dietary needs

## 🚀 Current Status

**Phase**: Phase 0 (Foundation) - Weeks 1-2  
**Next**: Phase 1 (Core Discovery Engine) - Weeks 3-8  
**Timeline**: 24-week development plan (3-6 months to MVP)

### ✅ Completed
- Project planning and architecture decisions
- Repository setup with comprehensive issue tracking
- Development standards and guidelines established
- CI/CD pipeline design
- Technical architecture finalized

### 🔨 In Progress
- Widget design library with dark bar aesthetic
- Firebase infrastructure setup
- Development environment configuration

### 📋 Upcoming
- Flutter project initialization
- Core ingredient management system
- Recipe filtering algorithms
- Real-time cocktail discovery

## 🛠 Technical Stack

- **Frontend**: Flutter (Material Design 3)
- **Backend**: Firebase (Firestore + Auth + Storage)
- **State Management**: Riverpod
- **Platform Priority**: Android first, then iOS/web
- **Design Theme**: Dark/sophisticated bar aesthetics
- **Testing**: Comprehensive unit, widget, and integration tests

## 📁 Project Structure
```
cocktail-recipe-app/
├── .ai-context.md              # Project context and decisions
├── lib/                        # Flutter source code
│   ├── core/                   # Constants, themes, utilities
│   ├── data/                   # Models, repositories, services
│   ├── providers/              # Riverpod state management
│   ├── widgets/                # Reusable UI components
│   ├── screens/                # App screens
│   └── main.dart              # App entry point
├── test/                       # Test files
│   ├── unit/                   # Unit tests
│   ├── widget/                 # Widget tests
│   └── integration/            # Integration tests
├── docs/                       # Documentation
├── assets/                     # Images and resources
└── android/ios/web/           # Platform-specific code
```

## 🎨 Design Language

### Dark Bar Aesthetic
- **Primary Colors**: Deep blacks (#1A1A1A) with gold accents (#FFD700)
- **Secondary**: Copper/bronze (#B87333) for warmth
- **Typography**: Elegant serif for cocktail names, clean sans-serif for body
- **Visual Elements**: Subtle gradients, glass effects, sophisticated shadows

### User Experience
- **Navigation**: Bottom nav for core features, drawer for utilities
- **Discovery Flow**: Type-to-search → ingredient selection → real-time suggestions
- **Recipe Display**: Missing ingredients highlighted, clear difficulty indicators
- **Inventory**: Simple checklist with smart categorization

## 📊 Development Phases

### Phase 0: Foundation (Weeks 1-2) - Current
- Widget design library with bar aesthetics
- CI/CD pipeline and infrastructure setup
- Development standards implementation

### Phase 1: Core Discovery Engine (Weeks 3-8)
- Ingredient management system
- Recipe database and filtering algorithms
- Real-time cocktail discovery
- 50 curated recipes, 200 ingredients

### Phase 2: Menu Planning & Utilities (Weeks 9-12)
- Menu planning tools
- Shopping list generation
- Recipe scaling and conversions
- Expand to 100 recipes

### Phase 3: Community Foundation (Weeks 13-18)
- User accounts and authentication
- Recipe submission system
- Rating and review functionality
- Content moderation tools

### Phase 4: Advanced Community (Weeks 19-24)
- Enhanced social features
- Advanced filtering and search
- User profiles and favorites
- Launch preparation and optimization

## 🚧 Quick Start

### Prerequisites
- Flutter SDK (latest stable)
- Firebase CLI
- Android Studio / VS Code
- Git

### Setup (Available after Phase 0)
```bash
# Clone the repository
git clone https://github.com/netanelklein/cocktail-recipe-app.git
cd cocktail-recipe-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

*Detailed setup instructions will be added during Phase 1 implementation.*

## 📋 Issues & Milestones

### Foundation Issues
- [#1 Phase 0: Widget Design Library](../../issues/1) - Dark bar aesthetic design system
- [#2 Development Phase Deliverables & Timeline](../../issues/2) - Complete project roadmap
- [#3 CI/CD Pipeline & Infrastructure Setup](../../issues/3) - Build and deployment automation
- [#4 Development Standards & Guidelines](../../issues/4) - Code quality and testing standards

### Implementation Issues
- [#5 Phase 1: Core Discovery Engine Implementation](../../issues/5) - Detailed development roadmap

### Milestones
- **Phase 0: Foundation** (Weeks 1-2)
- **Phase 1: Core Discovery Engine** (Weeks 3-8)
- **Phase 2: Menu Planning & Utilities** (Weeks 9-12)
- **Phase 3: Community Foundation** (Weeks 13-18)
- **Phase 4: Advanced Community** (Weeks 19-24)

## 📈 Business Model

### Revenue Strategy
- **Phase 1 (0-1K users)**: Completely free, no ads
- **Phase 2 (1K+ users)**: Introduce targeted, native ads
- **Phase 3 (Future)**: Optional premium subscription

### Target Audience
- Home bartenders and cocktail enthusiasts
- Age group: 18-35, global market
- Users who value quality ingredients and craftsmanship

## 🧪 Testing Strategy

### Comprehensive Testing
- **Unit Tests**: All business logic and algorithms
- **Widget Tests**: Every custom UI component
- **Integration Tests**: End-to-end user flows
- **Performance Tests**: Filtering speed and memory usage
- **Beta Testing**: Closed testing with friends/family starting Phase 1

### Quality Standards
- Minimum 80% code coverage
- Zero warnings in `flutter analyze`
- Performance targets: <3s cold start, <100ms filtering response

## 🤝 Contributing

### Current Phase (Solo Development)
This project is in active solo development through Phase 2. Focus areas:
- Widget design library implementation
- Core discovery engine development
- Infrastructure and testing setup

### Future Community Involvement
Community contributions will be welcomed starting in Phase 3 when user-generated content features are implemented.

### Development Workflow
- Direct commits to `main` branch during Phase 0-1
- Comprehensive testing before all commits
- Follow established [development standards](../../issues/4)
- Update `.ai-context.md` with major architectural decisions

## 📄 License

License will be determined before public release. Currently private development project.

## 📞 Contact

- **Developer**: netanelklein
- **Repository**: [cocktail-recipe-app](https://github.com/netanelklein/cocktail-recipe-app)
- **Issues**: Use GitHub issues for bug reports and feature requests

---

*Last Updated: 2025-06-19 21:32:07 UTC*  
*Status: Phase 0 Foundation - Ready for Development*
