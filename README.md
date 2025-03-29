# EduForge - E-Learning Platform

EduForge is a modern e-learning platform built with Ruby on Rails, designed to provide an interactive and engaging learning experience. This platform facilitates online education through various features and tools.

## Features

- User authentication and authorization
- Course management system
- Interactive learning materials
- Progress tracking
- Assessment system

## Tech Stack

- Ruby on Rails
- PostgreSQL
- Devise for authentication
- Tailwind CSS for styling
- Hotwire (Turbo & Stimulus) for dynamic interactions
- PgHero for database monitoring

## Prerequisites

- Ruby 3.4.2
- PostgreSQL
- Node.js
- Bun

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/eduforge.git
   cd eduforge
   ```

2. Install dependencies:
   ```bash
   bundle install
   bun install
   ```

3. Setup database:
   ```bash
   bin/rails db:create db:migrate
   ```

4. Start the development server:
   ```bash
   bin/dev
   ```

5. Visit http://localhost:3000

## Docker Development Setup

Alternatively, you can use Docker for development:

1. Build and start the containers:
   ```bash
   docker compose up --build
   ```

2. Setup the database (in another terminal):
   ```bash
   docker compose exec eduforge bin/rails db:setup
   ```

3. Visit http://localhost:3000

Useful Docker commands:
- Stop the application: `docker compose down`
- View logs: `docker compose logs -f`
- Run tests: `docker compose exec eduforge bin/rails spec`
- Run console: `docker compose exec eduforge bin/rails console`

## Testing

Run the test suite:
```bash
bin/rails spec
```

## Deployment

The application is configured for deployment using Kamal:

```bash
bin/kamal deploy
```

## Production Logging with Lograge

This application utilizes [Lograge](https://github.com/roidrage/lograge) in the production environment to provide cleaner, more structured, and actionable logs.

-   **Enabled:** Lograge is enabled in `config/environments/production.rb`.
-   **Format:** Logs are formatted as JSON (`Lograge::Formatters::Json`), making them easily parseable by log aggregation systems like ELK, Datadog, Splunk, etc.
-   **Custom Fields:** Each log entry includes the following custom fields for enhanced context:
    -   `exception`: The class name of any exception that occurred during the request.
    -   `exception_message`: The message associated with the exception.
    *   `time`: The timestamp when the log event occurred (using the application's time zone).
    *   `host`: The hostname of the server processing the request.
    *   `pid`: The process ID of the Rails application instance.
-   **Log File:** Lograge output is directed to `log/lograge_production.log`.
-   **Original Rails Log:** The standard verbose Rails log (`log/production.log`) is also kept (`config.lograge.keep_original_rails_log = true`) for more detailed debugging if needed, though the Lograge JSON output is preferred for monitoring and analysis.

## Database Configuration Details

### Default Timestamp Type

To ensure consistency and proper handling of time zones, an initializer (`config/initializers/postgres.rb`) configures ActiveRecord's PostgreSQL adapter to use `timestamptz` (timestamp with time zone) as the default data type for columns defined as `:datetime` in migrations.

This ensures that all timestamp fields in the PostgreSQL database store timezone information, preventing potential ambiguity when dealing with users or data across different time zones.