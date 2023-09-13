import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

const origin = process.env.CORS_ORIGIN;

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({ origin });
  await app.listen(5000);
}
bootstrap();
