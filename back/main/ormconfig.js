module.exports = {
  type: process.env.TYPEORM_CONNECTION || 'mysql',
  host: process.env.HOST || 'localhost',
  port: process.env.TYPEORM_PORT ||3306,
  username: process.env.TYPEORM_USERNAME || 'root',
  password: process.env.TYPEORM_PASSWORD || 'toor',
  database: process.env.TYPEORM_DATABASE || 'LOGIN',
  synchronize:  process.env.TYPEORM_SYNCHRONIZE || true,
  entities: process.env.TYPEORM_ENTITIES || ['dist/**/*.entity{.ts,.js}'],
  migrations: process.env.TYPEORM_MIGRATIONS ||['dist/seeds/*{.ts,.js}'],
  migrationsRun: process.env.TYPEORM_MIGRATIONS_RUN || true,
};
