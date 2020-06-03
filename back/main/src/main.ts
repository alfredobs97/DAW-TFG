import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
const PORT =  process.env.PORT || 3000;

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  console.log('Listen in: ' + PORT);
  await app.listen(PORT);
}
bootstrap();
