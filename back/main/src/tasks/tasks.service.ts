import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { dtoTask } from './dto/task.dto';
import { Task } from './task.entity';
import { dtoTaskAssign } from './dto/task-assign.dto';
import { dtoTaskDone } from './dto/task-done.dto';
import { User } from 'src/login/user.entity';

@Injectable()
export class TasksService {
  constructor(
    @InjectRepository(Task)
    private taskRepository: Repository<Task>,
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async create(dtoTask: dtoTask) {
    const toUser = await this.usersRepository.findOne({ username: dtoTask.to });
    const fromUser = await this.usersRepository.findOne({
      username: dtoTask.from,
    });

    const task = Object.assign(new Task(), dtoTask) as Task;

    task.to = toUser;
    task.from = fromUser;

    return this.taskRepository.save(task);
  }

  getAll() {
    return this.taskRepository.find();
  }

  delete(id: number) {
    return this.taskRepository.delete({ id: id });
  }

  async assignTask(dtoTaskAssign: dtoTaskAssign) {
    const toUser = await this.usersRepository.findOne({
      username: dtoTaskAssign.to,
    });
    const fromUser = await this.usersRepository.findOne({
      username: dtoTaskAssign.from,
    });

    const task = Object.assign(new Task(), dtoTask) as Task;

    task.to = toUser;
    task.from = fromUser;

    return this.taskRepository.update({ id: dtoTaskAssign.id }, task);
  }

  async finishTask(dtoTaskDone: dtoTaskDone){
    // @ts-ignore this is because dto not convert 'true' to boolean
    return console.log( await this.taskRepository.update({ id: dtoTaskDone.id }, {isDone: dtoTaskDone.isDone == 'true'}));
    //console.log(this.taskRepository.createQueryBuilder().update(Task).set({isDone: true}).where('id = :id', {id: dtoTaskDone.id}));
  }

  async getTaskFromUser(username: string): Promise<Task[]> {
    /*  const { tasksAssigned } = await this.usersRepository.findOne({
      where: { username: username },
      relations: ['tasksAssigned'],
    }); */

    const tasks = await this.taskRepository
      .createQueryBuilder('task')
      .leftJoinAndSelect('task.from', 'user.tasksMade')
      .leftJoinAndSelect('task.to', 'user.taskAssigned')
      .where('user.taskAssigned.username = :username', { username: username })
      .andWhere('task.isDone = false')
      .select(
        ['task.id','task.name', 'task.priority', 'task.description', 'task.isDone','user.tasksMade.username', 'user.taskAssigned.username']
      )
      .getMany();

    return tasks;
  }

  async getTaskMadeFromUser(username: string): Promise<Task[]> {
    const { tasksMade } = await this.usersRepository.findOne({
      where: { username: username },
      relations: ['tasksMade'],
    });

    return tasksMade;
  }
}
