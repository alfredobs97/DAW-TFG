import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { Task } from '../tasks/task.entity';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  username: string;

  @Column()
  name: string;

  @Column()
  pass: string;

  @Column()
  tel: number;

  @Column({ default: false })
  isAdmin: boolean;

  @OneToMany(type => Task, task => task.to,{ cascade: true,})
  tasksAssigned: Task[];

  @OneToMany(type => Task, task => task.from,{ cascade: true,})
  tasksMade: Task[];
}