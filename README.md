# blog-v2-backend

Rails 7 API for Hannah's blog. Powers the public frontend and admin CMS.

## Requirements

- Ruby 3.2.2
- PostgreSQL

## Setup

```bash
bundle install
rails db:create db:migrate db:seed
```

Create an admin user in the console:

```bash
rails console
User.create!(email: 'you@example.com', password: 'your-password')
```

## Environment variables

| Variable | Description |
|----------|-------------|
| `API_KEY_HMAC_SECRET_KEY` | Secret for hashing API keys (required in all environments) |
| `DATABASE_URL` | PostgreSQL connection (production) |
| `AWS_*` | Active Storage S3 credentials (production) |

## Run locally

```bash
rails server   # http://localhost:3000
```

## API overview

| Endpoint | Auth | Description |
|----------|------|-------------|
| `GET /posts` | Public | Paginated posts (`?items=10&page=1`) |
| `GET /posts/:id` | Public | Single post with comments |
| `POST /comments` | Public | Create a comment |
| `POST /api_keys` | Basic auth | Login (returns bearer token) |
| Mutating post/comment/image routes | Bearer token | Admin only |
