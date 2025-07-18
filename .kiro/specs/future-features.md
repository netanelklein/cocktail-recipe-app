# Future Features - Cocktailian App

This document tracks feature ideas and enhancements for future development phases beyond Phase 1.

## 🎯 **Approved for Future Development**

### **Phase 2 Priority Features**

#### 1. **Techniques & Methods Collection**
- **Purpose**: Educational bartending techniques library
- **Structure**: 
  ```javascript
  techniques/{techniqueId} {
    name: "Dry Shake",
    description: "Shake without ice first, then with ice",
    difficulty: 3,
    videoUrl: "https://...",
    equipment: ["shaker", "strainer"],
    whenToUse: "For cocktails with egg whites or cream",
    tips: ["Shake vigorously for 10-15 seconds without ice first"],
    usedInCocktails: ["whiskey-sour", "ramos-gin-fizz"]
  }
  ```
- **Value**: Educational content, fits bartending theme perfectly

#### 2. **Collections & Menus** ⭐ **HIGH PRIORITY**
- **Purpose**: Core feature - create recipe sheets for evenings with friends
- **Structure**:
  ```javascript
  collections/{collectionId} {
    name: "Summer Patio Drinks",
    description: "Light, refreshing cocktails perfect for outdoor entertaining",
    userId: "user-123",
    cocktailIds: ["gin-tonic", "mojito", "aperol-spritz"],
    isPublic: true,
    tags: ["summer", "refreshing", "low-abv"],
    likes: 45,
    createdAt: timestamp,
    type: "user-created" // vs "curated", "seasonal"
  }
  ```
- **Value**: Original app vision - menu planning for social events

#### 3. **Recipe Variations with Advanced Features**
- **Versioning System**: Track edit history, likes, forks
- **Structure**:
  ```javascript
  recipe_variations/{variationId} {
    // ... existing fields
    version: 2,
    isPublic: true,
    editHistory: [
      {version: 1, editedAt: timestamp, changes: "Updated gin ratio"},
      {version: 2, editedAt: timestamp, changes: "Added garnish note"}
    ],
    publicSince: timestamp,
    allowEdits: true,
    likes: 23,
    forks: 5 // how many people forked this variation
  }
  ```
- **Features**: Public sharing, editing, forking, version control

### **Phase 3+ Considerations**

#### 4. **Skill Progression & Gamification**
- **Purpose**: User engagement and retention
- **Structure**:
  ```javascript
  user_progress/{userId} {
    level: 3,
    experiencePoints: 1250,
    badges: ["stirred-master", "citrus-expert", "classic-connoisseur"],
    completedCocktails: ["martini", "manhattan", "old-fashioned"],
    masteredTechniques: ["stirring", "shaking", "muddling"],
    currentChallenges: ["make-5-gin-cocktails", "master-egg-white-drinks"]
  }
  ```
- **Value**: Gamification to increase user engagement

#### 5. **Equipment & Glassware**
- **Purpose**: Practical bartending guidance
- **Structure**:
  ```javascript
  equipment/{equipmentId} {
    name: "Coupe Glass",
    type: "glassware", // glassware, tool, garnish-tool
    description: "Elegant stemmed glass for up cocktails",
    capacity: "4-6 oz",
    alternatives: ["martini-glass", "nick-and-nora"],
    isEssential: true,
    usedInCocktails: ["martini", "manhattan", "aviation"]
  }
  ```
- **Status**: Interesting but complex, future consideration

#### 6. **Cocktail History & Stories**
- **Purpose**: Rich context for classic cocktails
- **Structure**: Add history object to cocktails collection
- **Status**: Nice but adds complexity, maybe later

## 🤔 **Ideas to Keep in Mind**

#### 7. **Cocktail Families & Relationships**
- **Purpose**: Track how cocktails relate to each other
- **Structure**:
  ```javascript
  cocktail_relationships/{relationshipId} {
    parentCocktailId: "martini-classic",
    childCocktailId: "dirty-martini", 
    relationshipType: "variation", // variation, riff, inspiration, family
    description: "Dirty Martini adds olive brine to classic Martini"
  }
  ```
- **Examples**: Martini → Dirty Martini, Negroni → Boulevardier
- **Status**: Keep for future consideration, might be valuable for discovery

## ❌ **Not Prioritized**

#### Ingredient Sourcing
- **Reason**: Global audience makes location-based sourcing impractical
- **Status**: Not planned for development

## 📋 **Implementation Notes**

### **Phase 2 Focus**
1. **Collections & Menus** - Highest priority (original app vision)
2. **Techniques Collection** - Educational value
3. **Enhanced Recipe Variations** - Community features

### **Architecture Considerations**
- Design Phase 1 data models to support these future features
- Plan Firestore security rules for user-generated content
- Consider performance implications of relationships and collections

### **User Experience Flow**
- Collections → Menu Planning → Shopping Lists → Recipe Execution
- Technique Learning → Skill Progression → Badge System
- Recipe Discovery → Variations → Community Sharing

---

*Last Updated: Phase 1 Planning*
*Next Review: After Phase 1 completion*