# Cocktailian Database Schema

This document defines the complete Firestore database structure for the Cocktailian app.

## Collections Overview

```
cocktailian/
├── categories/              # Ingredient and cocktail categories
├── ingredients/             # Base ingredients (no embedded recipes)
├── recipes/                 # All recipes (cocktails, ingredients, techniques)
├── users/                   # User profiles
├── user_inventories/        # Personal ingredient inventories
└── reviews/                 # Cocktail reviews and ratings (Phase 2+)
```

## Collection Schemas

### 1. `categories` Collection

**Purpose**: Organize ingredients and recipes into categories

```javascript
categories/{categoryId} {
  id: string,                    // Document ID
  name: string,                  // "Spirits", "Classic Cocktails"
  type: "ingredient" | "recipe", // Category type
  description: string,           // Category description
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Examples**:

- `spirits`: "Spirits", type: "ingredient"
- `classic-cocktails`: "Classic Cocktails", type: "recipe"

### 2. `ingredients` Collection

**Purpose**: Base ingredients (no embedded recipes)

```javascript
ingredients/{ingredientId} {
  id: string,                    // Document ID
  name: string,                  // "Gin", "Simple Syrup"
  categoryId: string,            // Reference to categories collection
  aliases: string[],             // ["london dry gin", "dry gin"]
  substitutes: string[],         // Array of ingredient IDs
  isAlcoholic: boolean,
  description: string,           // Ingredient description
  commonBrands: string[],        // ["Tanqueray", "Bombay Sapphire"]
  abv?: number,                  // Alcohol by volume (if alcoholic)

  // User submission fields
  status: "approved" | "pending" | "rejected", // Moderation status
  submittedBy?: string,          // userId if user-submitted
  moderationNotes?: string,      // Admin notes for moderation

  createdAt: timestamp,
  updatedAt: timestamp,
  createdBy: "admin" | string    // "admin" or userId for user-submitted
}
```

### 3. `recipes` Collection

**Purpose**: All recipes (cocktails, ingredients, techniques) with ratio-based system

```javascript
recipes/{recipeId} {
  id: string,                    // Document ID
  name: string,                  // "My Perfect Negroni", "Rich Demerara Syrup"
  type: "cocktail" | "ingredient" | "technique", // Recipe type
  categoryId: string,            // Reference to categories collection

  // Ratio-based ingredient system
  baseUnit: string,              // "ml", "oz", "cl" - primary unit
  baseAmount: number,            // 22.5 - what 1 ratio unit equals

  ingredients: Array<{
    ingredientId: string,        // Reference to ingredients collection
    ratio: number,               // 2, 1, 1 for 2:1:1 negroni
    optional: boolean,           // Is ingredient optional?
    specificBrand?: string,      // "Carpano Antica Formula"
    notes?: string               // "expressed, not muddled"
  }>,

  instructions: string[],        // Step-by-step instructions
  difficulty: 1 | 2 | 3 | 4 | 5, // Difficulty level
  prepTimeMinutes: number,
  description: string,           // Recipe description
  imageUrl?: string,             // Recipe image URL
  tags: string[],                // ["whiskey", "stirred", "classic"]

  // Cocktail-specific fields
  glassware?: string,            // "rocks", "coupe", "highball"
  variations?: string[],         // Array of related recipe IDs
  baseRecipeId?: string,         // If this is a variation of another
  variationType?: "riff" | "substitution" | "strength" | "garnish",

  // Ingredient recipe-specific fields
  ingredientId?: string,         // Reference to ingredient this recipe makes
  yieldAmount?: string,          // "1.5"
  yieldUnit?: string,            // "cups"
  shelfLife?: string,            // "1 month refrigerated"

  // Rating system
  averageRating: number,         // Calculated average (0-5)
  ratingCount: number,           // Number of ratings

  // User submission fields
  status: "approved" | "pending" | "rejected", // Moderation status
  submittedBy?: string,          // userId if user-submitted
  moderationNotes?: string,      // Admin notes for moderation

  // Metadata
  createdAt: timestamp,
  updatedAt: timestamp,
  createdBy: "admin" | string    // "admin" or userId for user-submitted
}
```

### 4. `users` Collection

**Purpose**: User profiles and preferences

```javascript
users/{userId} {
  id: string,                    // Document ID (matches Auth UID)
  email: string,
  displayName?: string,
  photoUrl?: string,

  preferences: {
    preferredTheme: "midnight-martini" | "whiskey-barrel" | "neon-nights" | "forest-gin",
    enableNotifications: boolean,
    dietaryRestrictions: string[], // ["vegan", "gluten-free"]
    maxDifficulty: 1 | 2 | 3 | 4 | 5,
    preferredUnits: "metric" | "imperial"
  },

  favoriteRecipeIds: string[],   // Array of cocktail IDs

  createdAt: timestamp,
  lastActiveAt: timestamp
}
```

### 5. `user_inventories` Collection

**Purpose**: Personal ingredient inventories for recipe filtering

```javascript
user_inventories/{userId} {
  userId: string,                // Document ID (matches users collection)
  ingredientIds: string[],       // Array of ingredient IDs user owns
  lastUpdated: timestamp,

  // Future: bar setup types, custom ingredient amounts, etc.
  barSetupType?: "basic" | "intermediate" | "advanced" | "custom"
}
```

### 6. `reviews` Collection (Phase 2+)

**Purpose**: User reviews and ratings for recipes

```javascript
reviews/{reviewId} {
  id: string,                    // Document ID
  recipeId: string,              // Reference to recipes collection
  userId: string,                // Reference to users collection

  rating: 1 | 2 | 3 | 4 | 5,     // Star rating
  reviewText?: string,           // Optional text review
  photos?: string[],             // Optional photo URLs

  helpfulVotes: number,          // Community helpfulness votes
  reportedCount: number,         // Moderation reports
  isVerified: boolean,           // User actually made the recipe

  createdAt: timestamp,
  updatedAt: timestamp
}
```

## Data Relationships

### Primary Relationships

- `recipes.categoryId` → `categories.id`
- `recipes.ingredients[].ingredientId` → `ingredients.id`
- `recipes.ingredientId` → `ingredients.id` (for ingredient recipes)
- `recipes.baseRecipeId` → `recipes.id` (for variations)
- `recipes.variations[]` → `recipes.id` (related recipes)
- `ingredients.categoryId` → `categories.id`
- `user_inventories.userId` → `users.id`
- `user_inventories.ingredientIds[]` → `ingredients.id`
- `reviews.recipeId` → `recipes.id`
- `reviews.userId` → `users.id`

### Data Integrity Rules

- All `categoryId` references must exist in `categories` collection
- All `ingredientId` references must exist in `ingredients` collection
- `user_inventories` document ID must match existing user
- Reviews can only be created by authenticated users

## Indexing Strategy

### Required Indexes

```javascript
// Recipes
recipes: [
  "type",
  "categoryId",
  "averageRating DESC",
  "difficulty ASC, averageRating DESC",
  "tags ARRAY_CONTAINS, averageRating DESC",
  "status",
  "type, categoryId",
  "type, averageRating DESC",
  "createdAt DESC",
];

// Ingredients
ingredients: ["categoryId", "isAlcoholic", "status", "name ASC"];

// Reviews
reviews: ["recipeId, createdAt DESC", "userId, createdAt DESC"];
```

## Security Rules Summary

### Phase 1 Rules

- **Public read**: `categories`, `ingredients`, `cocktails`
- **Admin write**: `categories`, `ingredients`, `cocktails`
- **User read/write**: `user_inventories` (own documents only)
- **No access**: `users`, `reviews` (not implemented yet)

### Future Authentication Rules

- Users can read/write their own `users` and `user_inventories`
- Users can create/edit their own `reviews`
- User-generated cocktails require authentication

## Migration Notes

### Phase 1 → Phase 2

- Add authentication requirements to security rules
- Implement user-generated content workflows
- Add review and rating aggregation

### Data Validation

- All required fields must be present
- Enum values must match defined options
- Array fields must contain valid references
- Timestamps automatically managed by Firestore

---

_Last Updated: Infrastructure Setup Phase_
_Next Review: After Phase 1 implementation_
