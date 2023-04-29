# Todos Service

## Table of Contents

- [Overview](#overview)
- [API Documentation](#api-documentation)

## Overview

Todos Service is a simple Rails API that allows users to manage their todo lists and items. The goal is for it to act as the backend for an updated version of the [Todos](https://github.com/brentsmyth/todos) react native app.

A production version of this app is running on Heroku @ https://todos-service.herokuapp.com

## API Documentation

This section outlines the API endpoints for the Todo Service.

### Authentication

All requests to the API must include a valid JWT token in the `Authorization` header. The token is obtained by authenticating with Google OAuth. A user will be created if it doesn't already exist, and the JWT token will contain the `user_id`.

You can get a JWT for the production app by visiting: https://todos-service.herokuapp.com/auth/google_oauth2_redirect

### Endpoints

#### Lists

##### 1. Create a new list

- URL: `/api/v1/lists`
- Method: `POST`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Body: `{ "name": "New List" }`
- Response: The created list object

##### 2. Get all lists

- URL: `/api/v1/lists`
- Method: `GET`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Response: An array of list objects

##### 3. Update a specific list

- URL: `/api/v1/lists/:id`
- Method: `PUT`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Body: `{ "name": "Updated List" }`
- Response: The updated list object

##### 4. Delete a specific list

- URL: `/api/v1/lists/:id`
- Method: `DELETE`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Response: Status code `204 (No Content)`

#### Items

##### 1. Create a new item

- URL: `/api/v1/lists/:list_id/items`
- Method: `POST`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Body: `{ "name": "New Item", "complete": false }`
- Response: The created item object

##### 2. Get all items for a specific list

- URL: `/api/v1/lists/:list_id/items`
- Method: `GET`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Response: An array of item objects

##### 3. Update a specific item

- URL: `/api/v1/items/:id`
- Method: `PUT`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Body: `{ "name": "Updated Item", "complete": true }`
- Response: The updated item object

##### 4. Delete a specific item

- URL: `/api/v1/items/:id`
- Method: `DELETE`
- Headers: `Authorization: Bearer JWT_TOKEN`
- Response: Status code `204 (No Content)`
