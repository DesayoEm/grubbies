# Recipe Social Platform - Product Requirements Document

## 1. Product Overview

### 1.1 Problem Statement
Food enthusiasts need a fully social platform to share recipes, connect with other cooks, and build a cooking community. Current platforms either lack robust social features or are too focused on recipe storage alone.

### 1.2 Target Users
- Home cooks
- Food bloggers 
- Recipe creators
- Cooking enthusiasts
- Social foodies

## 2. Functional Requirements

### 2.1 User Management
#### Core User Features
- User registration with:
  - Username (unique)
  - Full name
  - Email (unique)
  - Password (hashed)
  - Date of birth (16+ verification)
  - Bio (optional)
  - Profile status (active/inactive)
  - Email verification status

#### Social Features
- Follow/unfollow users
- View followers/following lists
- User activity feed
- Profile customization
- User search and discovery

### 2.2 Recipe Management
#### Core Recipe Features
- Create recipes with:
  - Title
  - Description
  - Ingredients list with quantities
  - Detailed instructions
  - Cooking time (in minutes)
  - Category (e.g., Dessert, Main Course)
  - Cuisine type
  - Servings (optional)
  - Calories per serving (optional)
  - Public/private visibility

#### Recipe Metadata
- Creation timestamp
- Last updated timestamp
- Author details
- Engagement metrics tracking
- Recipe status/visibility

### 2.3 Social Engagement System
#### Likes
- Like/unlike recipes
- Track like timestamps
- Prevent duplicate likes
- Like counts per recipe
- View users who liked

#### Comments
- Comment on recipes
- Reply to existing comments
- Edit own comments
- Delete own comments
- Comment timestamps
- Track edited status
- Nested comment threads
- Comment moderation flags

#### Shares
- Share recipes internally
- Track share metrics
- Share timestamps
- Share attribution

## 3. Technical Implementation

### 3.1 Database Schema
```sql
-- User Management
CREATE TABLE user_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    bio VARCHAR(300),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- For hashed password
    dob DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOL DEFAULT TRUE,
    is_verified BOOL DEFAULT FALSE
);

-- Recipe Management
CREATE TABLE recipe_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id CHAR(36) NOT NULL,
    description TEXT NOT NULL,
    ingredients_list TEXT NOT NULL,
    instructions TEXT NOT NULL,
    cooking_time INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    servings INT,
    calories_per_serving INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_public BOOL DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES user_data(id)
);

-- Engagement Tables
CREATE TABLE like_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    recipe_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_data(id),
    FOREIGN KEY (recipe_id) REFERENCES recipe_data(id),
    UNIQUE KEY unique_like (recipe_id, user_id)
);

CREATE TABLE comments_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    recipe_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    content TEXT NOT NULL,
    parent_comment_id CHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_edited BOOL DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES user_data(id),
    FOREIGN KEY (recipe_id) REFERENCES recipe_data(id),
    FOREIGN KEY (parent_comment_id) REFERENCES comments_data(id)
);

CREATE TABLE share_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    recipe_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_data(id),
    FOREIGN KEY (recipe_id) REFERENCES recipe_data(id)
);
```

### 3.2 API Endpoints

#### User Management
```
POST   /api/v1/users/register
POST   /api/v1/users/login
GET    /api/v1/users/me
PUT    /api/v1/users/me
GET    /api/v1/users/{id}
GET    /api/v1/users/{id}/followers
GET    /api/v1/users/{id}/following
POST   /api/v1/users/{id}/follow
DELETE /api/v1/users/{id}/follow
```

#### Recipe Management
```
GET    /api/v1/recipes
POST   /api/v1/recipes
GET    /api/v1/recipes/{id}
PUT    /api/v1/recipes/{id}
DELETE /api/v1/recipes/{id}
GET    /api/v1/recipes/user/{user_id}
GET    /api/v1/recipes/feed
GET    /api/v1/recipes/trending
```

#### Engagement
```
POST   /api/v1/recipes/{id}/like
DELETE /api/v1/recipes/{id}/like
GET    /api/v1/recipes/{id}/likes

POST   /api/v1/recipes/{id}/comments
GET    /api/v1/recipes/{id}/comments
PUT    /api/v1/comments/{id}
DELETE /api/v1/comments/{id}
POST   /api/v1/comments/{id}/reply

POST   /api/v1/recipes/{id}/share
GET    /api/v1/recipes/{id}/shares
```

## 4. Security Requirements
- Password hashing using bcrypt
- JWT authentication
- Email verification
- Age verification
- Rate limiting
- Input validation
- XSS protection
- CSRF protection

## 5. Performance Requirements
- API response time < 200ms
- Database query optimization
- Proper indexing
- Connection pooling
- Error rate < 1%
- System uptime > 99.9%

## 6. Project Structure
```
app/
├── models/
│   ├── users.py         # User Pydantic models
│   ├── recipes.py       # Recipe Pydantic models
│   └── engagement.py    # Engagement models
├── database/
│   └── database.py      # Database connection
├── crud/
│   ├── users.py         # User operations
│   ├── recipes.py       # Recipe operations
│   └── engagement.py    # Engagement operations
├── routers/
│   ├── users.py         # User endpoints
│   ├── recipes.py       # Recipe endpoints
│   └── engagement.py    # Engagement endpoints
├── core/
│   ├── config.py        # Settings
│   ├── security.py      # Auth logic
│   └── errors.py        # Error handling
└── main.py
```

## 7. Success Metrics
- User growth rate
- Recipe creation rate
- User engagement (likes, comments, shares)
- Active users per day/month
- Average time spent on platform
- Recipe completion rate
- User retention rate
- Community growth metrics

## 8. Error Handling
- Detailed error messages
- Error logging system
- Error tracking
- User-friendly error responses
- Service recovery procedures
- Rate limit notifications
- Database transaction rollbacks
