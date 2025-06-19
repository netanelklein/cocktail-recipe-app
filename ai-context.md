# Cocktail Recipe Community App - Project Context

**Project Owner**: netanelklein  
**Last Updated**: 2025-06-19 21:25:20  
**Status**: ✅ Repository Fully Organized - Ready for Development

## Project Overview
A Flutter-based cocktail recipe discovery app focused on ingredient-based filtering with community features and potential commercial viability.

## Development Resources & Timeline
- **Capacity**: 10-15 hours/week (solo development with GitHub Copilot)
- **Timeline**: 3-6 months to MVP launch (24 weeks total)
- **Platform Priority**: Android first, then iOS/web (lay foundations early)
- **Testing**: Closed beta with friends/family starting Phase 1
- **Growth Strategy**: Hybrid ASO + organic growth (organic priority)

## ✅ REPOSITORY STATUS

### ✅ Repository Setup: Complete and Ready
- **Repository**: `cocktail-recipe-app` ✅ Created and active
- **Labels**: ✅ Created (all phase, type, priority, component labels)
- **Milestones**: ✅ Created for all 5 phases (Phase 0 through Phase 4)
- **Foundation Issues Created**: 
  - ✅ Issue #1: Phase 0 Widget Design Library (design, phase-0, priority-high)
  - ✅ Issue #2: Development Phase Deliverables & Timeline (planning, documentation, priority-high)
  - ✅ Issue #3: CI/CD Pipeline & Infrastructure Setup (infrastructure, development, backend, priority-high)
  - ✅ Issue #4: Development Standards & Guidelines (documentation, development, priority-high, planning, testing)
  - ✅ Issue #5: Phase 1: Core Discovery Engine Implementation (backend, development, frontend, phase-1, priority-high)
- **Status**: Complete project setup - ready to begin development

### ✅ All Setup Decisions Finalized
- **Design Theme**: Dark/sophisticated with bar aesthetics
- **State Management**: Riverpod from day 1
- **CI/CD Strategy**: Defined (flutter analyze, AAB builds, branch strategy)
- **Development Approach**: Design-first (Phase 0 → implementation)

## ✅ COMPLETE PROJECT CHARACTERIZATION

### ✅ Project Vision & Goals
- **Problem**: Ingredient-based cocktail discovery for home bartenders
- **Target**: Home bartenders, cocktail enthusiasts (18-35, global)
- **Goal**: Viable commercial product starting as personal/portfolio project
- **Success Metric**: Large user base contributing recipes and ratings

### ✅ Core Features (MVP Requirements)
**Essential Features:**
- Ingredient-based filtering (primary)
- Regular recipe search
- Personal ingredient inventory
- Recipe ratings/reviews
- User recipe submissions
- Menu planning (Phase 2 priority)
- Shopping list generation

**Later Features:**
- User profiles
- Recipe sharing
- Recipe scaling/conversions
- Complex ingredient substitutions

### ✅ Technical Architecture
- **Backend**: Firebase (Firestore + Auth + Storage)
- **Database**: NoSQL/Firestore for flexibility
- **State Management**: ✅ Riverpod (confirmed)
- **API**: REST for MVP → Real-time later
- **Images**: Firebase Storage + curated/AI-generated
- **AI Integration**: OpenAI DALL-E (post-MVP due to costs)

### ✅ User Experience Design
**Design Language**: Material Design with dark sophisticated bar aesthetics
**Theme**: Dark/sophisticated with bar elements (bottles, glasses, wood textures)

**Navigation**:
- Bottom nav: Home/Discovery, Search, Inventory, Menu Planning
- Drawer: Recipe submission, Print formats, Settings, Tools

**Core UX Flow**:
- Type-to-search with autocomplete for ingredients
- Tag-based ingredient selection
- Real-time cocktail suggestions during ingredient selection
- Result priority: Exact matches → Substitution matches → Almost possible

**Recipe Display**:
- Ingredients: Spirits/mixers together, garnishes separate
- Missing ingredients highlighted in red
- Ratings at top, reviews at bottom
- Simple vs step-by-step instructions based on complexity
- Links to syrup/addition recipes

**Inventory Management**:
- Simple checklist (no quantities)
- Categorized ingredients
- Search + autocomplete for adding
- Manual entry with validation concerns

### ✅ Community Features Scope
**Recipe Submission**:
- Required: name, ingredients, instructions, image (no user uploads)
- Optional: author, taste profile tags, categorization
- Moderation required before publishing
- Platform owns recipes, users have "My Recipes" section
- Users can edit with approval process

**Rating & Review System**:
- 5-star rating system
- Optional text reviews with photos allowed
- Helpful/unhelpful voting on reviews
- User restrictions for abuse prevention

**Content Management**:
- No anonymous submissions (username required)
- Plus icon for adding missing ingredients (with review)
- Low-rated recipes deprioritized, not hidden
- Reporting system for inappropriate content
- Manual moderation initially → automated later

### ✅ Business Model & Monetization
**Revenue Strategy**: Ad-supported free app
- **Phase 1 (0-1K users)**: Completely free, no ads
- **Phase 2 (1K+ users)**: Introduce targeted ads
- **Phase 3 (Future)**: Optional subscription for cost-heavy features only

**Ad Strategy**:
- Native ad widgets styled like cocktail entries
- Targeted advertising (automated)
- No pop-ups or intrusive formats
- Designed to feel organic to user experience

**Premium Features** (future, subscription-based):
- Ad-free experience
- AI recipe generation (if costs justify)
- Advanced API integrations with ongoing costs
- Cloud backup/sync for multi-device

### ✅ Development Timeline & Platform Strategy
**Platform Priority**: Android first, then iOS and web

**Development Phases** (revised with Phase 0):
0. **Widget Design Library** (Weeks 1-2): Design system with bar aesthetics
1. **Core Discovery Engine** (Weeks 3-8): Ingredient filtering + recipe viewing
2. **Menu Planning & Utilities** (Weeks 9-12): Original project inspiration
3. **Community Foundation** (Weeks 13-18): User accounts + recipe submissions
4. **Advanced Community** (Weeks 19-24): Enhanced social features

**Testing Strategy**: Closed beta with friends/family, immediate feedback gathering

### ✅ Specific Deliverables Defined
- Phase-by-phase deliverables with success criteria
- Cross-phase testing and documentation requirements
- Clear technical milestones for each development period

## Content Strategy
- ~100 curated recipes at launch (50 in Phase 1, expand to 100 in Phase 2)
- High-quality images required
- Simple ingredient substitutions (bourbon ↔ whiskey)
- Dietary restrictions support (kosher, halal, vegan)
- ~200 common ingredients database

## 🚀 CURRENT STATUS
**✅ SETUP PHASE COMPLETE:**
- ✅ All major project decisions made and documented
- ✅ Repository created with comprehensive label system
- ✅ Milestones created for all development phases
- ✅ Complete foundation issues created:
  - Issue #1: Phase 0 Widget Design Library
  - Issue #2: Development Phase Deliverables & Timeline
  - Issue #3: CI/CD Pipeline & Infrastructure Setup
  - Issue #4: Development Standards & Guidelines
  - Issue #5: Phase 1: Core Discovery Engine Implementation

**🎯 READY TO START DEVELOPMENT:**
- **Phase 0**: Widget Design Library + Infrastructure Setup (Issues #1, #3)
- **Phase 1**: Detailed implementation roadmap ready (Issue #5)
- **Development Standards**: Comprehensive guidelines established (Issue #4)
- **Project Timeline**: Complete 24-week roadmap documented (Issue #2)

**Next Immediate Actions:**
1. **Begin Phase 0**: Start widget design library creation and infrastructure setup
2. **Parallel Work**: Can work on widget design while setting up Firebase infrastructure
3. **Focus Areas**: Dark bar aesthetic theme, Firebase configuration, CI/CD pipeline

**Status**: Project fully planned and organized - ready for development execution
