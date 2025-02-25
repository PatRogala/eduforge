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

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you have any questions or need help with setup, please open an issue in the GitHub repository.
