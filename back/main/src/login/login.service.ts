import {
  Injectable,
  HttpService,
  BadGatewayException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { User } from './user.entity';
import { UserDto } from './dto/user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { UserLoginDto } from './dto/userLogin.dto';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class LoginService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
    private httpService: HttpService,
    private jwtService: JwtService,
  ) {}

  async createUser(userDto: UserDto) {
    const { pass } = userDto;

    const response = await this.httpService
      .post(process.env.PASSWORD_BACKEND_ENCRYPT, { pass: pass })
      .toPromise();

    if (response.status !== 200) {
      //TODO rethink statusCode
      throw new BadGatewayException();
    }

    userDto.pass = response.data;

    const user = Object.assign(new User(), userDto);

    this.usersRepository.save(user);
  }

  async login(userLoginDto: UserLoginDto) {
    const { username, pass } = userLoginDto;

    const userInDb = await this.usersRepository.findOne({ username: username });

    if (!userInDb) {
      throw new NotFoundException();
    }

    try {
      await this.httpService
        .post(process.env.PASSWORD_BACKEND_DECRYPT, {
          passPlain: pass,
          passEncrypt: userInDb.pass,
        })
        .toPromise();

      return this.createToken(userInDb);
    } catch (_) {
      throw new ForbiddenException();
    }
  }

  findAll(): Promise<User[]> {
    return this.usersRepository.find();
  }

  private createToken(user: User) {
    const payload = {
      username: user.username,
      sub: user.id,
      isAdmin: user.isAdmin,
    };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
