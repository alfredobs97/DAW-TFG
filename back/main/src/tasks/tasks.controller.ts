import {
  Controller,
  Post,
  Body,
  Get,
  Delete,
  Put,
  Param,
  UseGuards,
} from '@nestjs/common';
import { dtoTask } from './dto/task.dto';
import { TasksService } from './tasks.service';
import { dtoTaskAssign } from './dto/task-assign.dto';
import { dtoTaskDone } from './dto/task-done.dto';
import { UserJwtAuthGuard } from '../jwt/user-jwt.guard';

@UseGuards(UserJwtAuthGuard)
@Controller('tasks')
export class TasksController {
  constructor(private taskService: TasksService) {}

  @Post('/create')
  createTask(@Body() dtoTask: dtoTask) {
    return this.taskService.create(dtoTask);
  }

  @Post('/finish')
  finishTask(@Body() dtoTaskDone: dtoTaskDone) {
    return this.taskService.finishTask(dtoTaskDone);
  }

  @Get()
  getTasks() {
    return this.taskService.getAll();
  }

  @Delete()
  deleteTask(@Body() id: number) {
    return this.taskService.delete(id);
  }

  @Put()
  assignTask(@Body() dtoTaskAssign: dtoTaskAssign) {
    return this.taskService.assignTask(dtoTaskAssign);
  }

  @Get('/assign/:username')
  getTaskFromUser(@Param('username') username: string) {
    return this.taskService.getTaskFromUser(username);
  }

  @Get('/made/:username')
  getTaskMadeFromUser(@Param('username') username: string) {
    return this.taskService.getTaskMadeFromUser(username);
  }
}
