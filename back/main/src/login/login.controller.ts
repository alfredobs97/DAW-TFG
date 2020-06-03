import { Controller, Get, Post, Body, UseGuards, Param } from '@nestjs/common';
import { LoginService } from './login.service';
import { UserDto } from './dto/user.dto';
import { UserLoginDto } from './dto/userLogin.dto';
import { UserJwtAuthGuard } from 'src/jwt/user-jwt.guard';

@Controller('login')
export class LoginController {
  constructor(private readonly loginService: LoginService) {}

  @Post('/createUser')
  createUser(@Body() userDto: UserDto){
    return this.loginService.createUser(userDto);
  }
  @Post()
  loginUser(@Body() userLogin: UserLoginDto){
    return this.loginService.login(userLogin);
  }
  
  /* @UseGuards(AdminJwtAuthGuard) */
  @UseGuards(UserJwtAuthGuard)
  @Get('/users')
  getUsers(){
    return this.loginService.findAll();
  }
}