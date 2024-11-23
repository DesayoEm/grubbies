SHOW DATABASES;
CREATE DATABASE users;
USE users;
CREATE TABLE user_data(
	id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
	user_name VARCHAR(10) NOT NULL,
    full_name VARCHAR (40) NOT NULL,
    bio VARCHAR (300),
    email VARCHAR (255) NOT NULL,
    password VARCHAR(10) NOT NULL,
    dob DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOL DEFAULT TRUE,
    is_verified BOOL DEFAULT FALSE
    );
    
    -- RECIPE DATA table
    CREATE TABLE recipe_data(
    id CHAR (36) DEFAULT (UUID()) PRIMARY KEY,
    title VARCHAR(60) NOT NULL,
    author_id CHAR (36) NOT NULL,
    description VARCHAR (500) NOT NULL,
    ingredients_list VARCHAR (500) NOT NULL,
    instructions VARCHAR (1500) NOT NULL,
    cooking_time INT NOT NULL, -- store in int, to be converted
    category VARCHAR (20) NOT NULL,
    cuisine VARCHAR (20) NOT NULL,
    servings INT,
    calories_per_serving INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_public BOOL,
    FOREIGN KEY (author_id) REFERENCES user_data(id)
    );
    
    -- ENGAGEMENT TABLES
    
    -- Likes table
    CREATE TABLE like_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    recipe_id CHAR(36) NOT NULL,
    user_id CHAR (36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_data(id),
    FOREIGN KEY (recipe_id) REFERENCES recipe_data(id),
    UNIQUE KEY unique_like (recipe_id, user_id)
    );
    
    -- Comments table
	CREATE TABLE comments_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    recipe_id CHAR(36) NOT NULL,
    user_id CHAR (36) NOT NULL,
    content TEXT NOT NULL,
    parent_comment_id CHAR (36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_edited BOOL DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES user_data(id),
    FOREIGN KEY (recipe_id) REFERENCES recipe_data(id),
    FOREIGN KEY (parent_comment_id) REFERENCES comments_data(id)
    );
    
    -- Shares table
	CREATE TABLE share_data(
    id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
    recipe_id CHAR(36) NOT NULL,
    user_id CHAR (36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_data(id),
    FOREIGN KEY (recipe_id) REFERENCES recipe_data(id)
    );
    
    

