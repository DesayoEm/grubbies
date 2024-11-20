# Recipe Management API - Product Requirements Document

## 1. Product Overview
### 1.1 Problem Statement
Home cooks and food enthusiasts need a centralized system to store, manage, and share their recipes, including photos of their dishes. Current solutions often lack proper image management or are too complex for basic use.

### 1.2 Target Users
- Home cooks
- Food bloggers
- Cooking enthusiasts
- Recipe collectors

## 2. Functional Requirements

### 2.1 Recipe Management
#### Core Recipe Features
- Create new recipes with:
  - Title
  - Description
  - Ingredients list (with quantities and units)
  - Step-by-step instructions
  - Cooking time
  - Servings
  - Difficulty level (Easy, Medium, Hard)
  - Preparation time
  - Cooking time
- Edit existing recipes
- Delete recipes
- View single recipe
- List all recipes with pagination

#### Recipe Metadata
- Creation date
- Last modified date
- Author information
- Category/tags
- Cuisine type

### 2.2 Image Management
#### Upload Requirements
- Support for common image formats (JPG, PNG)
- Maximum file size: 5MB
- Multiple images per recipe
- Minimum image dimensions: 800x600px
- Maximum image dimensions: 3000x2000px

#### Image Features
- Upload images with recipes
- Update/replace images
- Delete images
- Retrieve images
- Set primary recipe image

### 2.3 Search and Filtering
- Search recipes by:
  - Title
  - Ingredients
  - Category
  - Cooking time
  - Difficulty level
- Filter recipes by:
  - Cooking time range
  - Number of ingredients
  - Difficulty level
  - Creation date

### 2.4 User Management
- Basic user registration
- User authentication
- User authorization for recipe operations
- User profile management

## 3. Technical Requirements

### 3.1 API Specifications
- RESTful API design
- JSON response format
- Standard HTTP status codes
- API versioning

### 3.2 Security Requirements
- JWT-based authentication
- Input validation
- File type validation
- Rate limiting
- Request size limits

### 3.3 Performance Requirements
- API response time < 200ms
- Image upload time < 3s
- Support for concurrent users
- Efficient image storage and retrieval

## 4. Implementation Phases

### Phase 1: Core Recipe Features (Day 1)
- Basic CRUD operations
- Recipe model implementation
- Input validation
- Error handling

### Phase 2: Image Management (Day 2)
- Image upload functionality
- Image retrieval
- File validation
- Error handling for files

### Phase 3: Search and Categories (Day 3)
- Search implementation
- Filtering system
- Categories/tags
- Sorting options

### Phase 4: User System (Day 4)
- User authentication
- Authorization
- User-recipe relationships
- Profile management

### Phase 5: Advanced Features (Day 5)
- Middleware implementation
- Rate limiting
- Logging system
- Background tasks

## 5. API Endpoints

### Recipe Endpoints
```
GET    /api/v1/recipes
POST   /api/v1/recipes
GET    /api/v1/recipes/{id}
PUT    /api/v1/recipes/{id}
DELETE /api/v1/recipes/{id}
```

### Image Endpoints
```
POST   /api/v1/recipes/{id}/images
GET    /api/v1/recipes/{id}/images
DELETE /api/v1/recipes/{id}/images/{image_id}
```

### User Endpoints
```
POST   /api/v1/users/register
POST   /api/v1/users/login
GET    /api/v1/users/me
PUT    /api/v1/users/me
```

### Search Endpoints
```
GET    /api/v1/recipes/search
GET    /api/v1/recipes/filter
```

## 6. Data Models

### Recipe Model
```python
class Recipe:
    id: int
    title: str
    description: str
    ingredients: List[Ingredient]
    instructions: List[str]
    cooking_time: int
    prep_time: int
    difficulty: DifficultyLevel
    servings: int
    images: List[Image]
    category: List[str]
    author_id: int
    created_at: datetime
    updated_at: datetime
```

### User Model
```python
class User:
    id: int
    username: str
    email: str
    password_hash: str
    created_at: datetime
    updated_at: datetime
```

## 7. Success Metrics
- API response times within specified limits
- Successful image upload rate > 99%
- Error rate < 1%
- User satisfaction with recipe management features
- System uptime > 99.9%

## 8. Future Considerations
- Recipe sharing functionality
- Social features (likes, comments)
- Nutritional information
- Recipe scaling
- Mobile app integration
- Database migration from in-memory storage
