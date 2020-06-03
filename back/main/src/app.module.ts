import { Module } from '@nestjs/common';
import { LoginModule } from './login/login.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TasksModule } from './tasks/tasks.module';


@Module({
  imports: [TypeOrmModule.forRoot(),
  LoginModule,
  TasksModule],
})
export class AppModule {}
