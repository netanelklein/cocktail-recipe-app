# Environment Configuration

## Development Environment
- **Firebase Project**: cocktailian-app-2025 (single project for MVP)
- **Database Mode**: Test mode (open access for development)
- **Authentication**: Email/Password + Google Sign-in enabled
- **Storage**: Test mode for development uploads

## Production Environment
- **Firebase Project**: cocktailian-app-2025 (same project, different security rules)
- **Database Mode**: Production mode with strict security rules
- **Authentication**: Production-ready with email verification
- **Storage**: Production security rules with file validation

## Security Configuration
- **Firestore Rules**: Restrictive rules implemented in firestore.rules
- **Storage Rules**: Size limits and content type validation
- **Authentication**: Email verification required for production
- **API Keys**: Protected via environment variables

## Migration Plan
When scaling beyond MVP:
1. Create separate dev/staging/prod Firebase projects
2. Update firebase.json with environment-specific configurations
3. Implement environment-based config switching
4. Set up separate CI/CD pipelines per environment

## Current Status
- Single Firebase project configured for development
- Security rules in place for production readiness
- CI/CD pipeline configured with Firebase App Distribution
- Ready for both development and production deployment
