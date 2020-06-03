import { Module } from '@nestjs/common';
import { TasksController } from './tasks.controller';
import { TasksService } from './tasks.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Task } from './task.entity';
import { User } from 'src/login/user.entity';
import { UserJwtStrategy } from 'src/jwt/user-jwt.strategy';

@Module({
  imports: [TypeOrmModule.forFeature([User,Task])],
  controllers: [TasksController],
  providers: [TasksService, UserJwtStrategy]
})
export class TasksModule {}
