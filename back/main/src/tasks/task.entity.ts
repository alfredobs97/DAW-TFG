import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { User } from '../login/user.entity';

@Entity()
export class Task {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  priority: string;

  @Column()
  description: string;

  @ManyToOne(type => User, user => user.tasksAssigned,)
  to: User;

  @ManyToOne(type => User, user => user.tasksMade)
  from: User;

  @Column({ default: false })
  isDone: boolean;
}