# Firestore Security Rules Testing

This document explains how to test the Firestore security rules for the Cocktailian app.

## Phase 1 Security Rules Overview

The current security rules are designed for Phase 1 development:

- **Recipes Collection**: Public read access, no write access (admin seeding only)
- **Ingredients Collection**: Public read access, no write access (admin seeding only)  
- **User Inventories**: Full read/write access (no authentication yet)

## Prerequisites

1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Initialize Firebase in project** (if not done):
   ```bash
   firebase init firestore
   ```

## Testing with Firebase Emulator

### 1. Start the Firestore Emulator

```bash
firebase emulators:start --only firestore
```

This will start the Firestore emulator on `http://localhost:8080`

### 2. Deploy Rules to Emulator

The emulator automatically loads rules from `firestore.rules` file.

### 3. Run Setup Tests

```bash
# Run the setup test script
./scripts/test_setup.sh
```

### 4. Manual Testing via Emulator UI

1. Open `http://localhost:4000` in your browser
2. Navigate to Firestore tab
3. Try creating/reading documents in different collections
4. Verify that the security rules work as expected

## Expected Test Results

✅ **Should ALLOW**:
- Reading from `recipes` collection
- Reading from `ingredients` collection  
- Reading from `user_inventories` collection
- Writing to `user_inventories` collection

❌ **Should DENY**:
- Writing to `recipes` collection
- Writing to `ingredients` collection
- Any access to undefined collections

## Deploying Rules to Production

⚠️ **Only deploy after thorough testing!**

```bash
firebase deploy --only firestore:rules
```

## Future Updates

When authentication is added in later phases:

1. **User Inventories** will require authentication:
   ```javascript
   allow read, write: if request.auth != null && request.auth.uid == userId;
   ```

2. **User-Generated Content** will be added with proper user validation

3. **Admin Roles** will be implemented for content moderation

## Troubleshooting

### Common Issues

1. **Permission Denied Errors**: Check that rules match your test cases
2. **Emulator Not Starting**: Ensure port 8080 is available
3. **Rules Not Updating**: Restart the emulator after rule changes

### Debug Tips

- Use Firebase Console to view real-time rule evaluations
- Add `console.log` statements in test script for debugging
- Check emulator logs for detailed error messages